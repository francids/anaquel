import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: FHeader.nested(
        title: const Text("Cambiar contraseña"),
        prefixActions: [
          FHeaderAction.back(
            onPress: () => context.pop(),
          ),
        ],
      ),
      contentPad: false,
      content: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const FTextField(
              label: Text('Contraseña actual'),
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              maxLines: 1,
              autofillHints: [AutofillHints.password],
              keyboardType: TextInputType.visiblePassword,
            ),
            const SizedBox(height: 16),
            const FTextField(
              label: Text('Nuevo contraseña'),
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              maxLines: 1,
              autofillHints: [AutofillHints.password],
              keyboardType: TextInputType.visiblePassword,
            ),
            const SizedBox(height: 16),
            const FTextField(
              label: Text('Confirmar nueva contraseña'),
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              maxLines: 1,
              autofillHints: [AutofillHints.password],
              keyboardType: TextInputType.visiblePassword,
            ),
            const FDivider(),
            FButton(
              onPress: () {},
              style: FButtonStyle.primary,
              label: const Text("Cambiar contraseña"),
            ),
          ],
        ),
      ),
    );
  }
}
