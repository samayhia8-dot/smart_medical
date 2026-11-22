import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:timeago/timeago.dart' as timeago;

import 'package:flutter_bloc/flutter_bloc.dart';
import '../Cubit/post_cubit.dart';
import '../Model/api_model.dart';
import 'comment.dart';

class PostCard extends StatelessWidget {
  final PostModel post;

  const PostCard({super.key, required this.post});

  static const _navy = Color(0xFF1B3A57);
  static const _grey = Color(0xFF6B8299);
  static const _teal = Color(0xFF1F8A8A);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(12),

      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.white,
            Color(0xFFD5EAF4),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildHeader(),
          SizedBox(height: 12),
          _buildContent(),
          Divider(height: 24),
          _buildFooter(context),
        ],
      ),
    );
  }


  Widget _buildHeader() {
    return Row(
      children: [
        CircleAvatar(
          radius: 22,
          backgroundColor: Color(0xFFD5F0F0),
          child: Icon(
            post.isDoctorPost ? Icons.person : Icons.local_hospital, // جديد
            color: _teal,
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                post.isDoctorPost ? 'Dr. ${post.sourceName}' : post.sourceName, // جديد
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: _navy,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              Text(
                post.isDoctorPost ? post.specialization : 'Medical Information', // جديد
                style: TextStyle(color: _grey, fontSize: 12),
              ),
              Text(
                timeago.format(post.publishedAt),
                style: TextStyle(color: _grey, fontSize: 11),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: post.isDoctorPost ? Color(0xFFD5F0F0) : Color(0xFFE6DDF7),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            post.isDoctorPost ? 'Doctor Post' : 'API Content',
            style: TextStyle(
              color: post.isDoctorPost ? _teal : Color(0xFF7B5BB5),
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }



  Widget _buildContent() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (post.imageUrl.isNotEmpty)
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: SizedBox(
              width: 120,
              height: 95,
              child: CachedNetworkImage(
                imageUrl: post.imageUrl,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(color: Color(0xFFEAF2F5)),
                errorWidget: (context, url, error) => Container(
                  color:  Color(0xFFEAF2F5),
                  child: Icon(Icons.image_not_supported, color: _grey),
                ),
              ),
            ),
          ),
        if (post.imageUrl.isNotEmpty)
          SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                post.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: _navy,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 6),
              Text(
                post.description,
                maxLines: post.isDoctorPost ? 6 : 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: _grey, fontSize: 12),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => context.read<PostCubit>().toggleLike(post),
          child: Icon(
            post.isLikedByMe ? Icons.favorite : Icons.favorite_border,
            color: post.isLikedByMe ? Colors.red : _grey,
            size: 22,
          ),
        ),
        SizedBox(width: 6),
        Text('${post.likesCount}', style:  TextStyle(color: _grey)),
        SizedBox(width: 20),
        GestureDetector(
          onTap: () async {
            final cubit = context.read<PostCubit>();

            await showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) => CommentsSheet(postUrl: post.id),
            );

            cubit.refreshInteractions();
          },
          child:  Icon(Icons.chat_bubble_outline, color: _grey, size: 20),
        ),
        SizedBox(width: 6),
        Text('${post.commentsCount}', style:  TextStyle(color: _grey)),
        Spacer(),
        //Icon(Icons.share_outlined, color: _teal, size: 22),
      ],
    );
  }
}