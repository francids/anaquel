import 'package:anaquel/data/models/user.dart';
import 'package:anaquel/utils/config.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserService {
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  final Dio _dio;

  UserService()
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

  Future<User> getUser() async {
    final response = await _dio.get(
      "/user",
      queryParameters: {
        "username": await secureStorage.read(key: "username"),
      },
    );

    if (response.statusCode == 200) {
      final User user = User.fromJson(response.data);
      return user;
    } else {
      throw Exception(response.statusMessage);
    }
  }
}
