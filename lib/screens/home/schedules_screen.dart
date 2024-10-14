import 'package:anaquel/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:anaquel/widgets/schedule_card.dart';
import 'package:go_router/go_router.dart';

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
            onPress: () => buildCreateScheduleDialog(context),
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
          const SizedBox(
            width: double.infinity,
            child: Text(
              "Para modificar una hora, mantéenla presionada.",
              style: TextStyle(
                color: AppColors.eerieBlack,
                fontSize: 15,
              ),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Future<dynamic> buildCreateScheduleDialog(BuildContext context) {
    return showAdaptiveDialog(
      context: context,
      builder: (context) => FDialog(
        title: const Text("Crear hora de lectura"),
        direction: Axis.vertical,
        body: Column(
          children: [
            const Text(
              "Selecciona la hora:",
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 16),
            const FTextField(
              label: Text('Etiqueta:'),
              hint: "Opcional",
              maxLines: 1,
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () async {
                TimeOfDay? pickedTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (pickedTime != null) {
                  print(pickedTime.format(context));
                }
              },
              child: const FTextField(
                label: Text('Hora:'),
                maxLines: 1,
                readOnly: true,
                enabled: false,
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
        actions: <FButton>[
          FButton(
            onPress: () => context.pop(),
            style: FButtonStyle.primary,
            label: const Text("Crear hora de lectura"),
          ),
          FButton(
            onPress: () => context.pop(),
            style: FButtonStyle.outline,
            label: const Text("Cancelar"),
          ),
        ],
      ),
    );
  }
}
