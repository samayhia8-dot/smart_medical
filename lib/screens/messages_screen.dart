
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../services/chat_service.dart';
import 'chat_screen.dart';

class MessagesScreen extends StatelessWidget {
  MessagesScreen({super.key});

  final ChatService _chatService = ChatService();

  String get currentUid => FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F8FC),
      appBar: AppBar(
        title: const Text(
          'Messages',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF14295B),
        foregroundColor: Colors.white,
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: _chatService.getUserChats(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Could not load conversations'),
            );
          }

          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final chats = snapshot.data!.docs.toList();

          chats.sort((a, b) {
            final aTime = a.data()['lastMessageAt'] as Timestamp?;
            final bTime = b.data()['lastMessageAt'] as Timestamp?;

            return (bTime?.millisecondsSinceEpoch ?? 0)
                .compareTo(aTime?.millisecondsSinceEpoch ?? 0);
          });

          if (chats.isEmpty) {
            return const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.chat_bubble_outline,
                    size: 60,
                    color: Color(0xFF9CCBEA),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'No conversations yet',
                    style: TextStyle(
                      color: Color(0xFF6B7A90),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: chats.length,
            itemBuilder: (context, index) {
              final data = chats[index].data();

              final patientId = data['patientId']?.toString() ?? '';
              final doctorId = data['doctorId']?.toString() ?? '';

              if (patientId.isEmpty || doctorId.isEmpty) {
                return const SizedBox.shrink();
              }

              final isDoctor = currentUid == doctorId;

              final otherName = isDoctor
                  ? (data['patientName'] ?? 'Patient').toString()
                  : (data['doctorName'] ?? 'Doctor').toString();

              final unreadCount = isDoctor
                  ? (data['unreadForDoctor'] ?? 0) as int
                  : (data['unreadForPatient'] ?? 0) as int;

              final lastMessage =
              (data['lastMessage'] ?? 'Start conversation').toString();

              return Card(
                elevation: 1,
                margin: const EdgeInsets.only(bottom: 12),
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 8,
                  ),
                  leading: CircleAvatar(
                    radius: 25,
                    backgroundColor: const Color(0xFFE3F1FC),
                    child: Icon(
                      isDoctor ? Icons.person : Icons.medical_services,
                      color: const Color(0xFF3B8FD6),
                    ),
                  ),
                  title: Text(
                    otherName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF14295B),
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(
                      lastMessage,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Color(0xFF6B7A90),
                      ),
                    ),
                  ),
                  trailing: unreadCount > 0
                      ? CircleAvatar(
                    radius: 12,
                    backgroundColor: const Color(0xFF4BA67E),
                    child: Text(
                      unreadCount.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                      ),
                    ),
                  )
                      : const Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: Color(0xFF9CCBEA),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ChatScreen(
                          patientId: patientId,
                          doctorId: doctorId,
                          otherUserName: otherName,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
