import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';

class EditScheduleScreen extends StatelessWidget {
  EditScheduleScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: FHeader.nested(
        title: const Text('Editando horario'),
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
                label: const Text('Título'),
                controller: _titleController,
                maxLines: 1,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'El título no puede estar vacío';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              FTextField(
                label: const Text('Hora'),
                initialValue: '08:00 AM',
                maxLines: 1,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'La hora no puede estar vacía';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              const SizedBox(height: 16),
              FButton(
                onPress: () {
                  if (!_formKey.currentState!.validate()) {
                    return;
                  }
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
