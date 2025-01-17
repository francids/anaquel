import 'package:anaquel/data/models/user_book.dart';
import 'package:anaquel/utils/config.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserBooksService {
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  final Dio _dio;

  UserBooksService()
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

  Future<List<UserBook>> getUserBooks() async {
    final response = await _dio.get(
      "/books/users",
      queryParameters: {
        "username": await secureStorage.read(key: "username"),
      },
    );

    if (response.statusCode == 200) {
      final List<UserBook> userBooks = (response.data as List)
          .map((userBook) => UserBook.fromJson(userBook))
          .toList();
      return userBooks;
    } else {
      throw Exception('Error al obtener los libros');
    }
  }

  Future<void> addUserBook(String bookId) async {
    final response = await _dio.post(
      "/books/users",
      queryParameters: {
        "book": bookId,
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Error al agregar el libro');
    }
  }

  Future<void> updateUserBookStatus(
    String bookId,
    UserBookStatus status,
  ) async {
    final response = await _dio.post(
      "/books/users/status",
      queryParameters: {
        "book": bookId,
        "status": (status == UserBookStatus.notRead)
            ? "Not read"
            : status.toString().split('.').last,
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Error al actualizar el estado del libro');
    }
  }

  Future<void> removeUserBook(String bookId) async {
    final response = await _dio.delete(
      "/books/users",
      queryParameters: {
        "book": bookId,
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Error al eliminar el libro');
    }
  }
}
