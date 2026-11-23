
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  String get currentUid => _auth.currentUser!.uid;

  String chatId(String patientId, String doctorId) {
    return '${patientId}_$doctorId';
  }

  CollectionReference<Map<String, dynamic>> messagesRef(
      String patientId,
      String doctorId,
      ) {
    return _firestore
        .collection('chats')
        .doc(chatId(patientId, doctorId))
        .collection('messages');
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getMessages(
      String patientId,
      String doctorId,
      ) {
    return messagesRef(patientId, doctorId)
        .orderBy('createdAt', descending: false)
        .snapshots();
  }

  Future<void> sendMessage({
    required String patientId,
    required String doctorId,
    required String receiverId,
    required String text,
    String? fileUrl,
    String? fileName,
    String? fileType,
  }) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception('User is not logged in');

    final isDoctor = user.uid == doctorId;
    final id = chatId(patientId, doctorId);

    final chatRef = _firestore.collection('chats').doc(id);
    final messageRef = chatRef.collection('messages').doc();

    final message = {
      'messageId': messageRef.id,
      'senderId': user.uid,
      'receiverId': receiverId,
      'text': text.trim(),
      'fileUrl': fileUrl,
      'fileName': fileName,
      'fileType': fileType,
      'createdAt': FieldValue.serverTimestamp(),
      'readAt': null,
      'status': 'sent',
    };

    final batch = _firestore.batch();

    batch.set(messageRef, message);

    batch.set(
      chatRef,
      {
        'patientId': patientId,
        'doctorId': doctorId,
        'participants': [patientId, doctorId],
        'lastMessage': text.trim().isNotEmpty
            ? text.trim()
            : (fileName ?? 'Attachment'),
        'lastMessageAt': FieldValue.serverTimestamp(),
        'lastSenderId': user.uid,
        'patientName': await _getName('patients', patientId),
        'doctorName': await _getName('doctors', doctorId),
        if (isDoctor)
          'unreadForPatient': FieldValue.increment(1)
        else
          'unreadForDoctor': FieldValue.increment(1),
      },
      SetOptions(merge: true),
    );

    await batch.commit();
  }

  Future<String> _getName(String collection, String uid) async {
    final doc = await _firestore.collection(collection).doc(uid).get();
    final data = doc.data();

    return (data?['fullName'] ??
        data?['name'] ??
        data?['email'] ??
        'User')
        .toString();
  }

  Future<void> uploadAttachment({
    required String patientId,
    required String doctorId,
    required String receiverId,
  }) async {
    final file = await FilePicker.pickFile(
      type: FileType.any,
    );

    if (file == null) return;

    final bytes = await file.readAsBytes();

    final path =
        'chat_files/${chatId(patientId, doctorId)}/${DateTime.now().millisecondsSinceEpoch}_${file.name}';

    final ref = _storage.ref().child(path);

    await ref.putData(bytes);

    final url = await ref.getDownloadURL();

    await sendMessage(
      patientId: patientId,
      doctorId: doctorId,
      receiverId: receiverId,
      text: '',
      fileUrl: url,
      fileName: file.name,
      fileType: file.extension ?? 'file',
    );
  }

  Future<void> markMessagesAsRead(
      String patientId,
      String doctorId,
      ) async {
    final unread = await messagesRef(patientId, doctorId)
        .where('receiverId', isEqualTo: currentUid)
        .where('readAt', isNull: true)
        .get();

    final batch = _firestore.batch();

    for (final doc in unread.docs) {
      batch.update(doc.reference, {
        'readAt': FieldValue.serverTimestamp(),
        'status': 'read',
      });
    }

    final isDoctor = currentUid == doctorId;

    batch.set(
      _firestore.collection('chats').doc(chatId(patientId, doctorId)),
      {
        if (isDoctor)
          'unreadForDoctor': 0
        else
          'unreadForPatient': 0,
      },
      SetOptions(merge: true),
    );

    await batch.commit();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getUserChats() {
    return _firestore
        .collection('chats')
        .where('participants', arrayContains: currentUid)
        .snapshots();
  }
}
