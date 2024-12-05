import 'package:anaquel/constants/colors.dart';
import 'package:anaquel/data/models/schedule.dart';
import 'package:anaquel/screens/edit_schedule_screen.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_touch_ripple/flutter_touch_ripple.dart';
import 'package:forui/forui.dart';
import 'package:shared_preferences/shared_preferences.dart';

final Map<String, int> dayMapping = {
  "monday": 1,
  "tuesday": 2,
  "wednesday": 3,
  "thursday": 4,
  "friday": 5,
  "saturday": 6,
  "sunday": 7,
};

class ScheduleCard extends StatefulWidget {
  const ScheduleCard({super.key, required this.schedule});

  final Schedule schedule;

  @override
  State<ScheduleCard> createState() => _ScheduleCardState();
}

class _ScheduleCardState extends State<ScheduleCard> {
  String formatDays(List<String> days) {
    if (days.length == 7) {
      return "schedules_screen.days.everyday".tr();
    }
    if (days.contains("Monday") &&
        days.contains("Tuesday") &&
        days.contains("Wednesday") &&
        days.contains("Thursday") &&
        days.contains("Friday") &&
        !days.contains("Saturday") &&
        !days.contains("Sunday")) {
      return "schedules_screen.days.weekdays".tr();
    }
    if (days.contains("Saturday") &&
        days.contains("Sunday") &&
        !days.contains("Monday") &&
        !days.contains("Tuesday") &&
        !days.contains("Wednesday") &&
        !days.contains("Thursday") &&
        !days.contains("Friday")) {
      return "schedules_screen.days.weekends".tr();
    }
    return days
        .map((day) =>
            ("schedules_screen.days.${day.toLowerCase()}").tr().substring(0, 3))
        .join(", ");
  }

  @override
  Widget build(BuildContext context) {
    return TouchRipple(
      rippleBorderRadius: BorderRadius.circular(8),
      onTap: () => Navigator.of(context).push(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              EditScheduleScreen(schedule: widget.schedule),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 1),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.antiFlashWhite,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Row(
              children: [
                FAssets.icons.tag(
                  height: 16,
                  width: 16,
                  colorFilter: ColorFilter.mode(
                    AppColors.night.withOpacity(0.6),
                    BlendMode.srcIn,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  widget.schedule.label,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: AppColors.night.withOpacity(0.6),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${widget.schedule.time.split(':')[0]}:${widget.schedule.time.split(':')[1]}',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                FSwitch(
                  value: widget.schedule.active,
                  onChange: (value) {
                    toggleSchedule(widget.schedule, value).then((_) {
                      setState(() {
                        widget.schedule.active = value;
                      });
                    });
                  },
                  enabled: true,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  formatDays(widget.schedule.days),
                  style: const TextStyle(
                    color: AppColors.eerieBlack,
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future toggleSchedule(Schedule schedule, bool toWhatBoolean) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!toWhatBoolean) {
      prefs.setBool("schedule-${schedule.id}", false);
      for (String day in schedule.days) {
        final int? dayNumber = dayMapping[day.toLowerCase()];
        if (dayNumber == null) continue;
        await AwesomeNotifications().cancelSchedule(
          schedule.id * 100 + dayNumber,
        );
      }
      schedule.active = false;
    } else {
      prefs.setBool("schedule-${schedule.id}", true);
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
              timeZone:
                  await AwesomeNotifications().getLocalTimeZoneIdentifier(),
            ),
          );
        } catch (e) {
          throw Exception("Error");
        }
      }
      schedule.active = true;
    }
  }
}
