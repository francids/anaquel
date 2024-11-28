import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';

enum ScheduleDay {
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
  sunday,
}

class CreateScheduleScreen extends StatefulWidget {
  const CreateScheduleScreen({super.key});

  @override
  State<CreateScheduleScreen> createState() => _CreateScheduleScreenState();
}

class _CreateScheduleScreenState extends State<CreateScheduleScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _labelController = TextEditingController();
  final FMultiSelectGroupController<ScheduleDay> _daysController =
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
                    value: ScheduleDay.monday,
                  ),
                  FSelectTile(
                    title: const Text("Martes"),
                    value: ScheduleDay.tuesday,
                  ),
                  FSelectTile(
                    title: const Text("Miércoles"),
                    value: ScheduleDay.wednesday,
                  ),
                  FSelectTile(
                    title: const Text("Jueves"),
                    value: ScheduleDay.thursday,
                  ),
                  FSelectTile(
                    title: const Text("Viernes"),
                    value: ScheduleDay.friday,
                  ),
                  FSelectTile(
                    title: const Text("Sábado"),
                    value: ScheduleDay.saturday,
                  ),
                  FSelectTile(
                    title: const Text("Domingo"),
                    value: ScheduleDay.sunday,
                  ),
                ],
              ),
              const FDivider(),
              FButton(
                onPress: () {
                  if (!_formKey.currentState!.validate()) {
                    return;
                  }
                  print("Título: ${_labelController.text}");
                  print("Hora: ${selectedTime.format(context)}");
                  print("Días seleccionados: ${_daysController.values}");
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
