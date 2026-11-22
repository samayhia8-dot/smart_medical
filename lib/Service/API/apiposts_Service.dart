import 'dart:math';



import 'package:dio/dio.dart';
import 'package:smart_medication_system/Firebase/FireStore/keys.dart';

import '../../Model/api_model.dart';


class PostsApiService {

  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'https://gnews.io/api/v4',
    connectTimeout: const Duration(seconds: 15),
    receiveTimeout: const Duration(seconds: 15),
  ));



  static const List<String> _topics = [
    'heart health',
    'diabetes',
    'nutrition',
    'medication',
    'immune system',
    'healthy diet',
    'blood pressure',
    'vitamins',
    'sleep health',
    'cholesterol',
  ];
  List<PostModel> _removeDuplicates(List<PostModel> posts) {
    final List<PostModel> result = [];
    final ids = <String>{};
    final titles = <String>{};

    for (var post in posts) {
      final title = post.title.toLowerCase().trim();

      if (!ids.contains(post.id) && !titles.contains(title)) {
        ids.add(post.id);
        titles.add(title);
        result.add(post);
      }
    }

    return result;
  }

  Future<List<PostModel>> _request(Map<String, dynamic> params) async {
    await Keys.load();
    params['lang'] = 'en';
    params['max'] = 10;
    params['apikey'] = Keys.gnews;

    try {
      final response = await _dio.get('/search', queryParameters: params);
      final articles = (response.data['articles'] as List?) ?? [];

      return _removeDuplicates(articles
          .map((e) => PostModel.fromJson(e as Map<String, dynamic>))
          .where((p) => p.title.isNotEmpty && p.imageUrl.isNotEmpty)
          .toList());
    } on DioException catch (e) {
      throw Exception(e.message ?? 'Failed to load posts');
    }
  }

  Future<List<PostModel>> fetchPosts() async {
    final random = Random();
    final topic = _topics[random.nextInt(_topics.length)];
    final sortBy = random.nextBool() ? 'publishedAt' : 'relevance';

    final posts = await _request({'q': topic, 'sortby': sortBy});
    posts.shuffle(random);
    return posts;
  }

  Future<List<PostModel>> searchPosts(String query) async {
    return await _request({'q': query});
  }
}
