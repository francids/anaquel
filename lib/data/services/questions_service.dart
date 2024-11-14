import 'package:anaquel/data/models/question.dart';
import 'package:anaquel/utils/config.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class QuestionsService {
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  final Dio _dio;

  QuestionsService()
      : _dio = Dio(
          BaseOptions(contentType: Headers.jsonContentType),
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

  Future<List<Question>> generateQuestions(
      String bookTitle, String bookAuthor) async {
    final response = await _dio.get(
      "${Config.baseIntelligenceUrl}/questions",
      queryParameters: {
        "bookTitle": bookTitle,
        "bookAuthor": bookAuthor,
      },
    );

    if (response.statusCode == 200) {
      final List<Question> questions = (response.data as List)
          .map((question) => Question.fromJson(question))
          .toList();
      return questions;
    } else {
      throw Exception(response.statusMessage);
    }
  }
}
