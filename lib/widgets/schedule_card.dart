import 'package:anaquel/constants/colors.dart';
import 'package:anaquel/data/models/schedule.dart';
import 'package:anaquel/screens/edit_schedule_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_touch_ripple/flutter_touch_ripple.dart';
import 'package:forui/forui.dart';

class ScheduleCard extends StatelessWidget {
  const ScheduleCard({super.key, required this.schedule});

  final Schedule schedule;

  String formatDays(List<String> days) {
    if (days.length == 7) {
      return "Everyday";
    }
    if (days.contains("Monday") &&
        days.contains("Tuesday") &&
        days.contains("Wednesday") &&
        days.contains("Thursday") &&
        days.contains("Friday") &&
        !days.contains("Saturday") &&
        !days.contains("Sunday")) {
      return "Weekdays";
    }
    if (days.contains("Saturday") &&
        days.contains("Sunday") &&
        !days.contains("Monday") &&
        !days.contains("Tuesday") &&
        !days.contains("Wednesday") &&
        !days.contains("Thursday") &&
        !days.contains("Friday")) {
      return "Weekends";
    }
    return days.map((day) => day.substring(0, 3)).join(', ');
  }

  @override
  Widget build(BuildContext context) {
    return TouchRipple(
      rippleBorderRadius: BorderRadius.circular(8),
      onTap: () => Navigator.of(context).push(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              EditScheduleScreen(schedule: schedule),
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
                  schedule.label,
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
                  '${schedule.time.split(':')[0]}:${schedule.time.split(':')[1]}',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const FSwitch(
                  value: true,
                  enabled: true,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  formatDays(schedule.days),
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
}
