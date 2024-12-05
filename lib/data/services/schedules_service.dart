import 'package:anaquel/data/models/schedule.dart';
import 'package:anaquel/utils/config.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  Future<void> createNotification(Schedule schedule) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool active = prefs.getBool("schedule-${schedule.id}") ?? true;
    if (active == false) return;

    final Map<String, int> dayMapping = {
      "monday": 1,
      "tuesday": 2,
      "wednesday": 3,
      "thursday": 4,
      "friday": 5,
      "saturday": 6,
      "sunday": 7,
    };

    for (String day in schedule.days) {
      final int? dayNumber = dayMapping[day.toLowerCase()];
      if (dayNumber == null) continue;

      try {
        await AwesomeNotifications().createNotification(
          content: NotificationContent(
            id: schedule.id * 100 + dayNumber,
            channelKey: "scheduled",
            title: "¡Hora de leer!",
            body: "¡Es hora de sumergirte en tu próxima aventura literaria!",
            notificationLayout: NotificationLayout.Default,
            category: NotificationCategory.Reminder,
          ),
          schedule: NotificationCalendar(
            weekday: dayNumber,
            hour: int.parse(schedule.time.split(":")[0]),
            minute: int.parse(schedule.time.split(":")[1]),
            second: 0,
            millisecond: 0,
            repeats: true,
            timeZone: await AwesomeNotifications().getLocalTimeZoneIdentifier(),
          ),
        );
      } catch (e) {
        throw Exception("Error al crear la notificación");
      }
    }
  }

  Future<List<Schedule>> getSchedules() async {
    try {
      final response = await _dio.get("/schedules/users/schedules");
      if (response.statusCode == 200) {
        final List<Schedule> schedules = (response.data as List)
            .map((schedule) => Schedule.fromJson(schedule))
            .toList();
        await AwesomeNotifications().cancelAllSchedules();
        for (final schedule in schedules) {
          await createNotification(schedule);
        }
        return schedules;
      } else {
        throw Exception(
            "Error al obtener los horarios: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error al obtener los horarios");
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

  Future<void> updateSchedule(Schedule schedule) async {
    final response = await _dio.put(
      "/schedules/users",
      data: {
        "id": schedule.id,
        "time": schedule.time,
        "label": schedule.label,
        "days": schedule.days,
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Error al actualizar el horario');
    }
  }

  Future<void> deleteSchedule(int id) async {
    final response = await _dio.delete(
      "/schedules/users",
      queryParameters: {
        "schedule": id,
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Error al eliminar el horario');
    }
  }
}
