import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../Firebase/FireStore/posts_interactioons.dart';
import '../Model/api_model.dart';
import '../Service/API/apiposts_Service.dart';



part 'post_state.dart';

class PostCubit extends Cubit<PostState> {
  final PostsApiService _apiService;
  final PostsInteractions _interactions = PostsInteractions();
  String? _searchQuery;
  PostCubit(this._apiService) : super(PostInitial());

  /// أول تحميل
  Future<void> loadPosts() async {
    _searchQuery = null;
    emit(PostLoading());

    try {
      final posts = await _loadAll();
      if (isClosed) return;
      emit(PostSuccess(posts));
    } catch (e) {
      if (isClosed) return;
      emit(PostError(_cleanMessage(e)));
    }
  }

  /// سحب الشاشة لتحت: الجداد تتبدل بالقديم
  Future<void> refreshPosts() async {
    if (_searchQuery != null) return;
    try {
      final posts = await _loadAll();
      if (isClosed) return;
      emit(PostSuccess(posts));
    } catch (e) {
      if (isClosed) return;
      if (state is! PostSuccess) {
        emit(PostError(_cleanMessage(e)));
      }
    }
  }

  /// النزول لآخر القائمة: دفعة جديدة تتضاف تحت القديمة
  Future<void> loadMore() async {
    if (_searchQuery != null) return;
    final current = state;
    if (current is! PostSuccess) return;
    if (current.isLoadingMore) return;
    final loadingState = PostSuccess(current.posts, isLoadingMore: true);
    emit(loadingState);

    try {
      final apiPosts = await _apiService.fetchPosts();
      final newPosts = await _withInteractions(apiPosts);
      if (isClosed) return;
      if (!identical(state, loadingState)) return;
      final all = List<PostModel>.from(current.posts);
      for (var post in newPosts) {
        final title = post.title.toLowerCase().trim();
        bool exists = false;

        for (var old in all) {
          if (old.id == post.id || old.title.toLowerCase().trim() == title) {
            exists = true;
          }
        }

        if (!exists) {
          all.add(post);
        }
      }

      emit(PostSuccess(all));
    } catch (_) {
      if (isClosed) return;
      if (!identical(state, loadingState)) return;

      emit(PostSuccess(current.posts));
    }
  }

  /// البحث بكلمة
  Future<void> searchPosts(String query) async {
    final text = query.trim();

    if (text.isEmpty) {
      await clearSearch();
      return;
    }

    _searchQuery = text;
    emit(PostLoading());

    try {
      final apiPosts = await _apiService.searchPosts(text);
      final posts = await _withInteractions(apiPosts);
      if (isClosed || _searchQuery != text) return;
      emit(PostSuccess(posts));
    } catch (e) {
      if (isClosed || _searchQuery != text) return;
      emit(PostError(_cleanMessage(e)));
    }
  }

  /// الرجوع للقائمة العادية
  Future<void> clearSearch() async {
    _searchQuery = null;
    await loadPosts();
  }
  ///firebase
  Future<List<PostModel>> _withInteractions(List<PostModel> posts) async {
    try {
      return await _interactions.addInteractions(posts);
    } catch (e) {
      return posts;
    }
  }

  // منشورات الدكاترة فوق، وبعدهم منشورات GNews
  Future<List<PostModel>> _loadAll() async {
    final apiPosts = await _apiService.fetchPosts();

    List<PostModel> doctorPosts = [];
    try {
      doctorPosts = await _interactions.getDoctorPosts();
    } catch (e) {
      doctorPosts = [];
    }

    List<PostModel> all = [];
    all.addAll(doctorPosts);
    all.addAll(apiPosts);

    return await _withInteractions(all);
  }

  Future<void> toggleLike(PostModel post) async {
    await _interactions.toggleLike(post.id);
    await refreshInteractions();
  }

  Future<void> refreshInteractions() async {
    final current = state;

    if (current is PostSuccess) {
      final posts = await _withInteractions(current.posts);

      if (isClosed) return;
      emit(PostSuccess(posts));
    }
  }

  String _cleanMessage(Object e) {
    return e.toString().replaceFirst('Exception: ', '');
  }
}