import 'package:anaquel/data/models/book.dart';
import 'package:anaquel/utils/config.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class BooksService {
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  final Dio _dio;

  BooksService()
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

  Future<List<Book>> searchBooks(String title) async {
    final response = await _dio.get(
      "/books",
      queryParameters: {
        "page": 0,
        "title": title,
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

  Future<Book> getBook(int id) async {
    final response = await _dio.get(
      "/books/$id",
    );

    if (response.statusCode == 200) {
      final Book book = Book.fromJson(response.data);
      return book;
    } else {
      throw Exception('Error al obtener el libro');
    }
  }
}
