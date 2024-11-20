import 'package:anaquel/data/models/book.dart';
import 'package:anaquel/data/models/collection.dart';
import 'package:anaquel/utils/config.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CollectionsService {
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  final Dio _dio;

  CollectionsService()
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

  Future<List<Collection>> getCollections() async {
    final response = await _dio.get(
      "/collection/user",
    );

    if (response.statusCode == 200) {
      final List<Collection> collections = (response.data as List)
          .map((collection) => Collection.fromJson(collection))
          .toList();
      return collections;
    } else {
      throw Exception(response.statusMessage);
    }
  }

  Future<List<Book>> getBooksFromCollection(String collectionId) async {
    final response = await _dio.get(
      "/collection/books/$collectionId",
    );

    if (response.statusCode == 200) {
      final List<Book> books =
          (response.data as List).map((book) => Book.fromJson(book)).toList();
      return books;
    } else {
      throw Exception(response.statusMessage);
    }
  }

  Future<List<Collection>> getCollectionsWithBooks() async {
    final collections = await getCollections();
    for (var collection in collections) {
      final books = await getBooksFromCollection(collection.id.toString());
      collection.books = books;
    }
    return collections;
  }

  Future<void> createCollection(String name, String color) async {
    final response = await _dio.post(
      "/collection",
      data: {
        "username": await secureStorage.read(key: "username"),
        "name": name,
        "color": color,
      },
    );

    if (response.statusCode != 200) {
      throw Exception(response.statusMessage);
    }
  }

  Future<void> addBookToCollection(String collectionId, String bookId) async {
    final response = await _dio.post(
      "/collection/book",
      data: {
        "bookId": bookId,
        "collectionId": collectionId,
      },
    );

    if (response.statusCode != 200) {
      throw Exception(response.statusMessage);
    }
  }

  Future<void> deleteCollection(String id) async {
    final response = await _dio.delete(
      "/collection/$id",
    );

    if (response.statusCode != 200) {
      throw Exception(response.statusMessage);
    }
  }
}
