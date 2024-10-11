import 'package:anaquel/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

import 'package:anaquel/widgets/schedule_card.dart';

List<String> _times = [
  '08:00 AM',
  '12:00 PM',
  '02:00 PM',
  '06:00 PM',
];

class SchedulesScreen extends StatelessWidget {
  const SchedulesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
      child: Column(
        children: [
          FButton(
            onPress: () {},
            style: FButtonStyle.primary,
            label: const Text("Crear hora de lectura"),
          ),
          FDivider(
            style: FDividerStyle(
              color: AppColors.antiFlashWhite,
              padding: const EdgeInsets.only(top: 16),
            ),
          ),
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return ScheduleCard(time: _times[index]);
            },
            itemCount: _times.length,
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(vertical: 16),
            separatorBuilder: (context, index) {
              return const SizedBox(height: 8);
            },
          ),
        ],
      ),
    );
  }
}