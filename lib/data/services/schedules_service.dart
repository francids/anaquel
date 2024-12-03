import 'package:anaquel/data/models/schedule.dart';
import 'package:anaquel/utils/config.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SchedulesService {
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  final Dio _dio;

  SchedulesService()
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

  Future<List<Schedule>> getSchedules() async {
    final response = await _dio.get(
      "/schedules/users/schedules",
    );

    if (response.statusCode == 200) {
      final List<Schedule> schedules = (response.data as List)
          .map((schedule) => Schedule.fromJson(schedule))
          .toList();
      return schedules;
    } else {
      throw Exception('Error al obtener los horarios');
    }
  }

  Future<void> addSchedule(Schedule schedule) async {
    final response = await _dio.post(
      "/schedules/users",
      data: {
        "username": ".",
        "label": schedule.label,
        "time": schedule.time,
        "days": schedule.days,
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Error al agregar el horario');
    }
  }
}
