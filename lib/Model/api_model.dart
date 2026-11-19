import 'package:equatable/equatable.dart';

class PostModel extends Equatable {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final DateTime publishedAt;
  final String sourceName;
  final int likesCount;
  final int commentsCount;
  final bool isLikedByMe;
  final bool isDoctorPost;
  final String specialization;
  const PostModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.publishedAt,
    required this.sourceName,
    this.likesCount = 0,
    this.commentsCount = 0,
    this.isLikedByMe = false,
    this.isDoctorPost = false,
    this.specialization = '',
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['url'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      imageUrl: json['image'] ?? '',
      publishedAt:
      DateTime.tryParse(json['publishedAt'] ?? '') ?? DateTime.now(),
      sourceName: json['source']?['name'] ?? 'Unknown',
    );
  }

  PostModel copyWith({
    int? likesCount,
    int? commentsCount,
    bool? isLikedByMe,
  }) {
    return PostModel(
      id: id,
      title: title,
      description: description,
      imageUrl: imageUrl,
      publishedAt: publishedAt,
      sourceName: sourceName,
      isDoctorPost: isDoctorPost,
      specialization: specialization,
      likesCount: likesCount ?? this.likesCount,
      commentsCount: commentsCount ?? this.commentsCount,
      isLikedByMe: isLikedByMe ?? this.isLikedByMe,
    );
  }

  @override
  List<Object?> get props =>
      [id, title, imageUrl, publishedAt, likesCount, commentsCount, isLikedByMe];
}