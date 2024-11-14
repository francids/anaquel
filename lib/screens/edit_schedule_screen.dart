import 'package:anaquel/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';

List<String> days = [
  'Lunes',
  'Martes',
  'Miércoles',
  'Jueves',
  'Viernes',
  'Sábado',
  'Domingo',
];

class EditScheduleScreen extends StatefulWidget {
  const EditScheduleScreen({super.key});

  @override
  State<EditScheduleScreen> createState() => _EditScheduleScreenState();
}

class _EditScheduleScreenState extends State<EditScheduleScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isSwitched = false;
  final TextEditingController _labelController = TextEditingController();
  TimeOfDay selectedTime = const TimeOfDay(hour: 8, minute: 0);
  List<bool> selectedDays = List.generate(days.length, (index) => false);

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
        title: const Text("Editando horario"),
        prefixActions: [
          FHeaderAction.back(
            onPress: () => context.pop(),
          ),
        ],
        suffixActions: [
          FHeaderAction(
            icon: FAssets.icons.delete(),
            onPress: () {
              showDialog(
                context: context,
                builder: (context) {
                  return FDialog(
                    title: const Text("Eliminar horario"),
                    body: const Text(
                      "¿Estás seguro de que deseas eliminar este horario?",
                    ),
                    actions: [
                      FButton(
                        onPress: () {
                          context.pop();
                          context.pop();
                        },
                        style: FButtonStyle.destructive,
                        label: const Text("Eliminar"),
                      ),
                      FButton(
                        onPress: () {
                          context.pop();
                        },
                        style: FButtonStyle.outline,
                        label: const Text("Cancelar"),
                      ),
                    ],
                  );
                },
              );
            },
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
              FCard(
                child: FSwitch(
                  label: const Text("Activar horario"),
                  value: isSwitched,
                  onChange: (bool? newValue) {
                    setState(() {
                      isSwitched = newValue ?? false;
                    });
                  },
                  enabled: true,
                ),
              ),
              const FDivider(),
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
              const SizedBox(
                width: double.infinity,
                child: Text(
                  "Días",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              const SizedBox(height: 8),
              Column(
                children: List.generate(days.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: FCheckbox(
                      label: Text(days[index]),
                      value: selectedDays[index],
                      onChange: (bool? newValue) {
                        setState(() {
                          selectedDays[index] = newValue ?? false;
                        });
                      },
                    ),
                  );
                }),
              ),
              // Validación de días
              if (selectedDays.every((element) => !element))
                const SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: Text(
                      "Debes seleccionar al menos un día",
                      style: TextStyle(
                        color: AppColors.eerieBlack,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              const FDivider(),
              FButton(
                onPress: () {
                  if (!_formKey.currentState!.validate()) {
                    return;
                  }
                  if (selectedDays.every((element) => !element)) {
                    return;
                  }
                  print("Título: ${_labelController.text}");
                  print("Hora: ${selectedTime.format(context)}");
                  print("Días seleccionados: ${selectedDays}");
                },
                style: FButtonStyle.primary,
                label: const Text('Guardar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
