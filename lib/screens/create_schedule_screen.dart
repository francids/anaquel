import 'package:anaquel/data/models/schedule.dart';
import 'package:anaquel/logic/schedules_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';

class CreateScheduleScreen extends StatefulWidget {
  const CreateScheduleScreen({super.key});

  @override
  State<CreateScheduleScreen> createState() => _CreateScheduleScreenState();
}

class _CreateScheduleScreenState extends State<CreateScheduleScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _labelController = TextEditingController();
  final FMultiSelectGroupController<String> _daysController =
      FMultiSelectGroupController();
  TimeOfDay selectedTime = const TimeOfDay(hour: 8, minute: 0);

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: FHeader.nested(
        title: const Text("Creando horario"),
        prefixActions: [
          FHeaderAction.back(
            onPress: () => context.pop(),
          ),
        ],
      ),
      contentPad: false,
      content: SingleChildScrollView(
        padding: EdgeInsets.only(
          top: 16,
          left: 16,
          right: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              FTextField(
                label: const Text("Etiqueta"),
                description: const Text("Ejemplo: Club de lectura"),
                controller: _labelController,
                maxLines: 1,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "El etiqueta no puede estar vacío";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () => _selectTime(context),
                child: AbsorbPointer(
                  child: FTextField(
                    label: const Text("Hora"),
                    controller: TextEditingController(
                      text: selectedTime.format(context),
                    ),
                    maxLines: 1,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "La hora no puede estar vacía";
                      }
                      return null;
                    },
                  ),
                ),
              ),
              const FDivider(),
              FSelectTileGroup(
                controller: _daysController,
                label: const Text("Días"),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Debes seleccionar al menos un día";
                  }
                  return null;
                },
                children: [
                  FSelectTile(
                    title: const Text("Lunes"),
                    value: "monday",
                  ),
                  FSelectTile(
                    title: const Text("Martes"),
                    value: "tuesday",
                  ),
                  FSelectTile(
                    title: const Text("Miércoles"),
                    value: "wednesday",
                  ),
                  FSelectTile(
                    title: const Text("Jueves"),
                    value: "thursday",
                  ),
                  FSelectTile(
                    title: const Text("Viernes"),
                    value: "friday",
                  ),
                  FSelectTile(
                    title: const Text("Sábado"),
                    value: "saturday",
                  ),
                  FSelectTile(
                    title: const Text("Domingo"),
                    value: "sunday",
                  ),
                ],
              ),
              const FDivider(),
              FButton(
                onPress: () {
                  if (!_formKey.currentState!.validate()) {
                    return;
                  }
                  String scheduleTime = DateFormat("HH:mm:ss").format(
                    DateTime(0, 1, 1, selectedTime.hour, selectedTime.minute),
                  );
                  Schedule schedule = Schedule(
                    id: 0,
                    label: _labelController.text,
                    time: scheduleTime,
                    days: _daysController.values.toList(),
                  );
                  context.read<SchedulesBloc>().add(AddSchedule(schedule));
                  context.pop();
                },
                style: FButtonStyle.primary,
                label: const Text('Crear horario'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
