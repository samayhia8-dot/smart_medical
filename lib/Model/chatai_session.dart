
import 'dart:convert';
import 'dart:typed_data';

import 'package:dash_chat_2/dash_chat_2.dart';

class ChatSession {
  final String id;
  String title;
  List<ChatMessage> messages;

  ChatSession({
    required this.id,
    required this.title,
    required this.messages,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'messages': messages.map((message) {
        final imageBytes = message.customProperties?['imageBytes'];

        return {
          'userId': message.user.id,
          'firstName': message.user.firstName,
          'profileImage': message.user.profileImage,
          'createdAt': message.createdAt.toIso8601String(),
          'text': message.text,
          'imageBytes': imageBytes is Uint8List
              ? base64Encode(imageBytes)
              : null,
          'imageName': message.customProperties?['imageName'],
        };
      }).toList(),
    };
  }

  factory ChatSession.fromJson(Map<String, dynamic> json) {
    final messages = (json['messages'] as List).map((item) {
      final data = Map<String, dynamic>.from(item as Map);
      final encodedImage = data['imageBytes'];

      final Uint8List? imageBytes = encodedImage is String
          ? base64Decode(encodedImage)
          : null;

      final user = ChatUser(
        id: data['userId'] as String,
        firstName: data['firstName'] as String?,
        profileImage: data['profileImage'] as String?,
      );

      return ChatMessage(
        user: user,
        createdAt: DateTime.parse(data['createdAt'] as String),
        text: data['text'] as String? ?? '',
        medias: imageBytes != null
            ? [
          ChatMedia(
            url: 'local-image',
            fileName: data['imageName'] as String? ?? 'image.png',
            type: MediaType.image,
          ),
        ]
            : [],
        customProperties: imageBytes != null
            ? {
          'imageBytes': imageBytes,
          'imageName': data['imageName'],
        }
            : null,
      );
    }).toList();

    return ChatSession(
      id: json['id'] as String,
      title: json['title'] as String,
      messages: messages,
    );
  }
}