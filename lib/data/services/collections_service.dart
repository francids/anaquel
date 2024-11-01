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

  Future<List<Collection>> getCollections() async {
    final response = await _dio.get(
      "/collection/user/${await secureStorage.read(key: "username")}",
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
}
