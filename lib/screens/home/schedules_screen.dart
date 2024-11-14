import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:anaquel/widgets/schedule_card.dart';
import 'package:go_router/go_router.dart';

List<String> _times = [
  '08:00 AM',
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
          const SizedBox(height: 8),
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return ScheduleCard(time: _times[index]);
            },
            itemCount: _times.length,
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(vertical: 16),
            separatorBuilder: (context, index) {
              return const SizedBox(height: 12);
            },
          ),
          const SizedBox(
            width: double.infinity,
            child: Text("Selecciona una hora para editar o eliminar"),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Future<dynamic> buildCreateScheduleDialog(BuildContext context) {
    TextEditingController _labelController = TextEditingController();
    TimeOfDay selectedTime = const TimeOfDay(hour: 8, minute: 0);
    TextEditingController _timeController = TextEditingController(
      text: selectedTime.format(context),
    );

    Future<void> _selectTime(BuildContext context) async {
      final TimeOfDay? picked = await showTimePicker(
        context: context,
        initialTime: selectedTime,
      );
      if (picked != null && picked != selectedTime) {
        selectedTime = picked;
        _timeController.text = selectedTime.format(context);
      }
    }

    return showAdaptiveDialog(
      context: context,
      builder: (context) => FDialog(
        title: const Text("Crear hora de lectura"),
        direction: Axis.vertical,
        body: Column(
          children: [
            const SizedBox(height: 16),
            FTextField(
              label: const Text('Etiqueta:'),
              hint: "Opcional",
              maxLines: 1,
              controller: _labelController,
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () => _selectTime(context),
              child: AbsorbPointer(
                child: FTextField(
                  label: const Text('Hora:'),
                  maxLines: 1,
                  controller: _timeController,
                ),
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
        actions: <FButton>[
          FButton(
            onPress: () {
              print("Etiqueta creada: ${_labelController.text}");
              print("Hora de lectura creada: ${selectedTime.format(context)}");
              context.pop();
            },
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
