import 'package:anaquel/constants/colors.dart';
import 'package:anaquel/screens/edit_schedule_screen.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

class ScheduleCard extends StatefulWidget {
  const ScheduleCard({super.key, required this.time});

  final String time;

  @override
  State<ScheduleCard> createState() => _ScheduleCardState();
}

class _ScheduleCardState extends State<ScheduleCard> {
  List<bool> isSelected = [true, true, true, false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const EditScheduleScreen(),
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
          borderRadius: BorderRadius.circular(16),
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
                  "Normal",
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
                  widget.time,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const FSwitch(
                  enabled: true,
                  // style: FSwitchStyle(
                  //   checkedColor: AppColors.burgundy,
                  //   uncheckedColor: AppColors.timberwolf,
                  //   focusColor: AppColors.burgundy,
                  //   thumbColor: AppColors.white,
                  // ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(isSelected.length, (index) {
                return GestureDetector(
                  onTap: () {
                    setState(() => isSelected[index] = !isSelected[index]);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: isSelected[index]
                          ? AppColors.burgundy
                          : AppColors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(
                        color: isSelected[index]
                            ? AppColors.burgundy
                            : AppColors.timberwolf,
                        width: 1,
                      ),
                    ),
                    width: 40,
                    height: 40,
                    child: Center(
                      child: Text(
                        ['L', 'M', 'M', 'J', 'V', 'S', 'D'][index],
                        style: TextStyle(
                          color: isSelected[index]
                              ? AppColors.white
                              : AppColors.night,
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
