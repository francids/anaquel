import 'package:anaquel/data/models/login_response.dart';
import 'package:anaquel/data/models/user.dart';
import 'package:anaquel/utils/config.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  final Dio _dio;
  final Map<String, bool> _usernameCache = {};

  AuthService()
      : _dio = Dio(
          BaseOptions(
            baseUrl: Config.baseUrl,
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
      String? cookie = response.headers.map['Set-Cookie']?.first;
      await secureStorage.write(
        key: "cookie",
        value: cookie,
      );
      return LoginResponse(cookie: cookie!);
    } else {
      throw Exception('Error al iniciar sesión');
    }
  }

  Future<void> logout() async {
    await secureStorage.delete(key: 'cookie');
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

  Future<String?> getCookie() async {
    return await secureStorage.read(key: "cookie");
  }

  Future<bool> usernameExists(String username) async {
    if (_usernameCache.containsKey(username)) {
      return _usernameCache[username]!;
    }

    final response = await _dio.get(
      "/auth/exists",
      queryParameters: {
        "username": username,
      },
    );

    bool exists = response.data as bool;
    _usernameCache[username] = exists;

    return exists;
  }

  Future<String> getVerificationCode(String email) async {
    final response = await _dio.post(
      "/auth/code",
      data: {
        "email": email,
      },
    );

    if (response.statusCode == 200) {
      return response.data["code"];
    } else {
      throw Exception('Error al obtener el código de verificación');
    }
  }

  Future<void> editUser(User user) async {
    final cookie = await getCookie();
    final response = await _dio.post(
      "/users",
      data: {
        "username": user.username,
        "name": user.name,
        "email": user.email,
      },
      options: Options(
        headers: {
          "Cookie": cookie,
        },
      ),
    );

    if (response.statusCode != 200) {
      throw Exception("Error al editar el usuario");
    }
  }

  Future<void> changePassword(String oldPassword, String newPassword) async {
    final cookie = await getCookie();
    final response = await _dio.put(
      "/users/credentials",
      data: {
        "oldPassword": oldPassword,
        "newPassword": newPassword,
      },
      options: Options(
        headers: {
          "Cookie": cookie,
        },
      ),
    );

    if (response.statusCode != 200) {
      throw Exception("Error al cambiar la contraseña");
    }
  }
}
