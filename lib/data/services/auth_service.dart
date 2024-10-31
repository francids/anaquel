import 'package:anaquel/data/models/login_response.dart';
import 'package:anaquel/data/models/user.dart';
import 'package:anaquel/utils/config.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  final Dio _dio;

  AuthService()
      : _dio = Dio(
          BaseOptions(
            baseUrl: Config.baseUrl!,
            contentType: Headers.jsonContentType,
          ),
        );

  Future<LoginResponse> login(User user) async {
    final response = await _dio.post(
      '/auth/login',
      data: {
        'username': user.username,
        'password': user.password,
      },
    );

    if (response.statusCode == 200) {
      final loginResponse = LoginResponse.fromJson(response.data);
      await secureStorage.write(
        key: "username",
        value: user.username,
      );
      await secureStorage.write(
        key: 'access_token',
        value: loginResponse.accessToken,
      );
      await secureStorage.write(
        key: 'token_type',
        value: loginResponse.tokenType,
      );
      return loginResponse;
    } else {
      throw Exception('Error al iniciar sesión');
    }
  }

  Future<void> logout() async {
    await secureStorage.delete(key: 'username');
    await secureStorage.delete(key: 'access_token');
    await secureStorage.delete(key: 'token_type');
  }

  Future signUp(User user) async {
    final response = await _dio.post(
      '/auth/register',
      data: {
        'username': user.username,
        'email': user.email,
        'name': user.name,
        'password': user.password,
      },
    );

    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('Error al registrarse');
    }
  }

  Future<String?> getToken() async {
    return await secureStorage.read(key: 'access_token');
  }

  Future<String?> getTokenType() async {
    return await secureStorage.read(key: 'token_type');
  }
}
