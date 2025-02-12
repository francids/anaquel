import 'package:anaquel/core/db/schedule_db.dart';
import 'package:anaquel/data/models/schedule.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SchedulesService {
  final ScheduleDB _scheduleDB = ScheduleDB();

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
            title: schedule.label,
            body: "schedules_screen.notification.body".tr(),
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
    final schedules = await _scheduleDB.fetchAll();

    if ((await AwesomeNotifications().listScheduledNotifications())
        .isNotEmpty) {
      await AwesomeNotifications().cancelAllSchedules();
    }

    for (final schedule in schedules) {
      await createNotification(schedule);
    }
    return schedules;
  }

  Future<void> addSchedule(Schedule schedule) async {
    await _scheduleDB.insert(schedule);
  }

  Future<void> updateSchedule(Schedule schedule) async {
    await _scheduleDB.update(schedule);
    await createNotification(schedule);
  }

  Future<void> deleteSchedule(int id) async {
    await _scheduleDB.delete(id);
    await AwesomeNotifications().cancel(id);
  }
}
