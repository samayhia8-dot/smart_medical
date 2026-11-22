import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../Model/api_model.dart';


class PostsInteractions {
  final db = FirebaseFirestore.instance;

  String getUid() {
    return FirebaseAuth.instance.currentUser?.uid ?? '';
  }
  String postId(String url) {
    return url.replaceAll('/', '_');
  }

  Future<List<PostModel>> addInteractions(List<PostModel> posts) async {
    final uid = getUid();

    if (uid.isEmpty) {
      return posts;
    }

    try {
      List<PostModel> result = [];

      for (var post in posts) {
        final doc = await db.collection('posts').doc(postId(post.id)).get();

        if (doc.exists) {
          List likedBy = doc['likedBy'];
          result.add(post.copyWith(
            likesCount: likedBy.length,
            commentsCount: doc['commentsCount'],
            isLikedByMe: likedBy.contains(uid),
          ));
        } else {
          result.add(post);
        }
      }

      return result;
    } catch (e) {
      print('>>> firestore error: $e');
      return posts;
    }
  }

  Future<void> toggleLike(String url) async {
    final uid = getUid();
    if (uid.isEmpty) return;

    final ref = db.collection('posts').doc(postId(url));
    final doc = await ref.get();

    List likedBy = [];
    int commentsCount = 0;

    if (doc.exists) {
      likedBy = List.from(doc['likedBy']);
      commentsCount = doc['commentsCount'];
    }

    if (likedBy.contains(uid)) {
      likedBy.remove(uid);
    } else {
      likedBy.add(uid);
    }

    await ref.set({
      'likedBy': likedBy,
      'commentsCount': commentsCount,
    });
  }

  Future<void> addComment(String url, String text) async {
    final uid = getUid();
    if (uid.isEmpty) return;

    final ref = db.collection('posts').doc(postId(url));
    final name = await getUserName();

    await ref.collection('comments').add({
      'userId': uid,
      'userName': name,
      'text': text,
      'time': DateTime.now(),
    });


    final doc = await ref.get();

    List likedBy = [];
    int commentsCount = 0;

    if (doc.exists) {
      likedBy = List.from(doc['likedBy']);
      commentsCount = doc['commentsCount'];
    }

    await ref.set({
      'likedBy': likedBy,
      'commentsCount': commentsCount + 1,
    });
  }

  Future<String> getUserName() async {
    final uid = getUid();

    final doctor = await db.collection('doctors').doc(uid).get();
    if (doctor.exists) return doctor['fullName'];

    final patient = await db.collection('patients').doc(uid).get();
    if (patient.exists) return patient['fullName'];

    return 'User';
  }

  Future<List<Map<String, dynamic>>> getComments(String url) async {
    final snapshot = await db
        .collection('posts')
        .doc(postId(url))
        .collection('comments')
        .orderBy('time')
        .get();

    return snapshot.docs.map((doc) => doc.data()).toList();
  }


  Future<void> addDoctorPost(String title, String text) async {
    final uid = getUid();
    if (uid.isEmpty) return;

    final doctor = await db.collection('doctors').doc(uid).get();
    if (!doctor.exists) return;

    await db.collection('doctorPosts').add({
      'doctorId': uid,
      'doctorName': doctor['fullName'],
      'specialization': doctor['specialization'],
      'title': title,
      'text': text,
      'time': DateTime.now(),
    });
  }

  Future<List<PostModel>> getDoctorPosts() async {
    final snapshot = await db
        .collection('doctorPosts')
        .orderBy('time', descending: true)
        .limit(20)
        .get();

    List<PostModel> posts = [];

    for (var doc in snapshot.docs) {
      posts.add(PostModel(
        id: 'doctor_${doc.id}',
        title: doc['title'],
        description: doc['text'],
        imageUrl: '',
        publishedAt: doc['time'].toDate(),
        sourceName: doc['doctorName'],
        isDoctorPost: true,
        specialization: doc['specialization'],
      ));
    }

    return posts;
  }
}