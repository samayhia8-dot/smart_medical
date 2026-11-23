
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:url_launcher/url_launcher.dart';

import '../services/chat_service.dart';

class ChatScreen extends StatefulWidget {
  final String patientId;
  final String doctorId;
  final String otherUserName;

  const ChatScreen({
    super.key,
    required this.patientId,
    required this.doctorId,
    required this.otherUserName,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ChatService _chatService = ChatService();
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  bool isSending = false;

  String get currentUid => FirebaseAuth.instance.currentUser!.uid;

  String get receiverId =>
      currentUid == widget.doctorId ? widget.patientId : widget.doctorId;

  @override
  void initState() {
    super.initState();
    _markAsRead();
  }

  Future<void> _markAsRead() async {
    try {
      await _chatService.markMessagesAsRead(
        widget.patientId,
        widget.doctorId,
      );
    } catch (e) {
      debugPrint('Mark as read error: $e');
    }
  }

  Future<void> _sendMessage() async {
    final text = _messageController.text.trim();

    if (text.isEmpty || isSending) return;

    setState(() => isSending = true);

    try {
      await _chatService.sendMessage(
        patientId: widget.patientId,
        doctorId: widget.doctorId,
        receiverId: receiverId,
        text: text,
      );

      _messageController.clear();
    } catch (e) {
      _showMessage('Could not send message: $e');
    } finally {
      if (mounted) {
        setState(() => isSending = false);
      }
    }
  }

  Future<void> _sendAttachment() async {
    try {
      await _chatService.uploadAttachment(
        patientId: widget.patientId,
        doctorId: widget.doctorId,
        receiverId: receiverId,
      );
    } catch (e) {
      _showMessage('Could not upload attachment: $e');
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Future<void> _openFile(String url) async {
    final uri = Uri.tryParse(url);

    if (uri == null || !await launchUrl(uri)) {
      _showMessage('Could not open this file');
    }
  }

  String _formatTime(dynamic timestamp) {
    if (timestamp is! Timestamp) return '';

    final date = timestamp.toDate();
    final hour = date.hour % 12 == 0 ? 12 : date.hour % 12;
    final minute = date.minute.toString().padLeft(2, '0');
    final period = date.hour >= 12 ? 'PM' : 'AM';

    return '$hour:$minute $period';
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F8FC),
      appBar: AppBar(
        backgroundColor: const Color(0xFF14295B),
        foregroundColor: Colors.white,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.otherUserName,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'Healix Chat',
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: _chatService.getMessages(
                widget.patientId,
                widget.doctorId,
              ),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text('Something went wrong'),
                  );
                }

                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final messages = snapshot.data!.docs;

                if (messages.isEmpty) {
                  return const Center(
                    child: Text(
                      'Start your conversation',
                      style: TextStyle(
                        color: Color(0xFF6B7A90),
                        fontSize: 15,
                      ),
                    ),
                  );
                }

                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (_scrollController.hasClients) {
                    _scrollController.jumpTo(
                      _scrollController.position.maxScrollExtent,
                    );
                  }
                });

                return ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(16),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final data = messages[index].data();
                    final isMe = data['senderId'] == currentUid;

                    return Align(
                      alignment: isMe
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.78,
                        ),
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: isMe
                              ? const Color(0xFF3B8FD6)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            if ((data['text'] ?? '').toString().isNotEmpty)
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  data['text'],
                                  style: TextStyle(
                                    color: isMe
                                        ? Colors.white
                                        : const Color(0xFF14295B),
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            if (data['fileUrl'] != null) ...[
                              const SizedBox(height: 8),
                              InkWell(
                                onTap: () => _openFile(data['fileUrl']),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      Icons.attach_file,
                                      color: Colors.white,
                                    ),
                                    Flexible(
                                      child: Text(
                                        data['fileName'] ?? 'Attachment',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          decoration:
                                          TextDecoration.underline,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                            const SizedBox(height: 5),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  _formatTime(data['createdAt']),
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: isMe
                                        ? Colors.white70
                                        : Colors.grey,
                                  ),
                                ),
                                if (isMe) ...[
                                  const SizedBox(width: 5),
                                  Icon(
                                    data['status'] == 'read'
                                        ? Icons.done_all
                                        : Icons.done,
                                    size: 15,
                                    color: data['status'] == 'read'
                                        ? Colors.lightBlueAccent
                                        : Colors.white70,
                                  ),
                                ],
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 10,
            ),
            color: Colors.white,
            child: SafeArea(
              top: false,
              child: Row(
                children: [
                  IconButton(
                    onPressed: _sendAttachment,
                    icon: const Icon(
                      Icons.attach_file,
                      color: Color(0xFF3B8FD6),
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      minLines: 1,
                      maxLines: 4,
                      decoration: InputDecoration(
                        hintText: 'Type a message...',
                        filled: true,
                        fillColor: const Color(0xFFF4F8FC),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 10,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  CircleAvatar(
                    backgroundColor: const Color(0xFF3B8FD6),
                    child: IconButton(
                      onPressed: isSending ? null : _sendMessage,
                      icon: isSending
                          ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                          : const Icon(
                        Icons.send,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
