part of 'post_cubit.dart';

@immutable
sealed class PostState {}

final class PostInitial extends PostState {}

final class PostLoading extends PostState {}

final class PostSuccess extends PostState {
  final List<PostModel> posts;
  final bool isLoadingMore;

  PostSuccess(this.posts, {this.isLoadingMore = false});
}

final class PostError extends PostState {
  final String message;

  PostError(this.message);
}