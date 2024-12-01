import 'package:anaquel/data/models/summary.dart';
import 'package:anaquel/utils/config.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SummaryService {
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  final Dio _dio;

  SummaryService()
      : _dio = Dio(
          BaseOptions(
            contentType: Headers.jsonContentType,
            baseUrl: Config.baseIntelligenceUrl,
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

  Future<String> generateSummary(
    String bookTitle,
    String bookAuthor,
    String language,
  ) async {
    final response = await _dio.get(
      "/summary",
      queryParameters: {
        "bookTitle": bookTitle,
        "bookAuthor": bookAuthor,
        "language": language,
      },
    );

    if (response.statusCode == 200) {
      final Summary summaryObject = Summary.fromJson(response.data);
      return summaryObject.summary;
    } else {
      throw Exception(response.statusMessage);
    }
  }
}
