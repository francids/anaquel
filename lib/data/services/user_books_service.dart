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
      "/books/user",
      queryParameters: {
        "username": await secureStorage.read(key: "username"),
      },
    );

    if (response.statusCode == 200) {
      final List<UserBook> userBooks = (response.data as List)
          .map((userBook) => UserBook.fromJson(userBook))
          .toList();

      // Imprimir todas las propiedades
      userBooks.forEach((userBook) {
        print(userBook.id);
        print(userBook.title);
        print(userBook.description);
        print(userBook.coverUrl);
        print(userBook.isbn);
        print(userBook.genres);
        print(userBook.authors);
        print(userBook.status);
        print(userBook.rating);
      });

      return userBooks;
    } else {
      throw Exception('Error al obtener los libros');
    }
  }

  Future<void> addUserBook(String bookId) async {
    final response = await _dio.post(
      "/books/user",
      queryParameters: {
        "book": bookId,
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Error al agregar el libro');
    }
  }
}
