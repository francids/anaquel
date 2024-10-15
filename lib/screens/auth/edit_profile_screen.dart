import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: FHeader.nested(
        title: const Text("Editar perfil"),
        leftActions: [
          FHeaderAction.back(onPress: () => context.pop()),
        ],
      ),
      contentPad: false,
      content: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            FAvatar(
              image: const NetworkImage(''),
              size: 150,
            ),
            const SizedBox(height: 8),
            const FTextField(
              label: Text("Nombre"),
              maxLines: 1,
              autofillHints: [AutofillHints.name],
              keyboardType: TextInputType.name,
            ),
            const SizedBox(height: 16),
            const FTextField(
              label: Text("Correo electrónico"),
              maxLines: 1,
              autofillHints: [AutofillHints.email],
              keyboardType: TextInputType.emailAddress,
            ),
            const FDivider(),
            FButton(
              onPress: () => context.pop(),
              style: FButtonStyle.primary,
              label: const Text("Editar perfil"),
            ),
          ],
        ),
      ),
    );
  }
}
