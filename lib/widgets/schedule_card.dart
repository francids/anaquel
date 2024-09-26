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
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFEEEEEE),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            children: [
              FAssets.icons.tag(
                height: 16,
                width: 16,
                colorFilter: const ColorFilter.mode(
                  Color(0x99151515),
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                "Normal",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: Color(0x99151515),
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
                style: FSwitchStyle(
                  checkedColor: Color(0xFF941932),
                  uncheckedColor: Color(0xFFD8D8D8),
                  focusColor: Color(0xFF941932),
                  thumbColor: Color(0xFFFBFBFB),
                ),
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
                        ? const Color(0xFF941932)
                        : const Color(0x00FBFBFB),
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(
                      color: isSelected[index]
                          ? const Color(0xFF941932)
                          : const Color(0xFFD8D8D8),
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
                            ? const Color(0xFFFBFBFB)
                            : const Color(0xFF151515),
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
    );
  }
}
