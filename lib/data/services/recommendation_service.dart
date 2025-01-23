import 'package:anaquel/data/models/recommendation_book.dart';
import 'package:anaquel/utils/config.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class RecommendationService {
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  final Dio _dio;

  RecommendationService()
      : _dio = Dio(
          BaseOptions(
            baseUrl: Config.baseUrl,
            contentType: Headers.jsonContentType,
          ),
        ) {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          String? cookie = await secureStorage.read(key: 'cookie');
          options.headers["Cookie"] = cookie;
          return handler.next(options);
        },
      ),
    );
  }

  Future<List<RecommendationBook>> getRecommendations(String bookId) async {
    final response = await _dio.get(
      "/books/recommendation",
      queryParameters: {
        "book": bookId,
      },
    );

    if (response.statusCode == 200) {
      final List<RecommendationBook> recommendations = (response.data as List)
          .map((recommendation) => RecommendationBook.fromJson(recommendation))
          .toList();
      return recommendations;
    } else {
      throw Exception(response.statusMessage);
    }
  }
}
