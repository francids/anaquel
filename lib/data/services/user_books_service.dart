import 'package:anaquel/data/models/book.dart';
import 'package:anaquel/utils/config.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserBooksService {
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  final Dio _dio;

  UserBooksService()
      : _dio = Dio(
          BaseOptions(
            baseUrl: Config.baseUrl!,
            contentType: Headers.jsonContentType,
          ),
        ) {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          String? token = await secureStorage.read(key: 'access_token');
          options.headers["Authorization"] = "Bearer $token";
          return handler.next(options);
        },
      ),
    );
  }

  Future<List<Book>> getUserBooks() async {
    final response = await _dio.get(
      "/books/user",
      queryParameters: {
        "username": await secureStorage.read(key: "username"),
      },
    );

    if (response.statusCode == 200) {
      final List<Book> books =
          (response.data as List).map((book) => Book.fromJson(book)).toList();
      return books;
    } else {
      throw Exception('Error al obtener los libros');
    }
  }
}
