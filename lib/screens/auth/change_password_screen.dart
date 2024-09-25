import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FTheme(
      data: FThemes.zinc.light,
      child: FScaffold(
        header: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: FHeader.nested(
            title: const Text("Cambiar contraseña"),
            leftActions: [
              FHeaderAction.back(
                onPress: () => context.go("/"),
              ),
            ],
          ),
        ),
        content: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(height: 6),
              const FTextField(
                label: Text('Contraseña actual'),
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                maxLines: 1,
              ),
              const SizedBox(height: 16),
              const FTextField(
                label: Text('Nuevo contraseña'),
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                maxLines: 1,
              ),
              const SizedBox(height: 16),
              const FTextField(
                label: Text('Confirmar nueva contraseña'),
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                maxLines: 1,
              ),
              const FDivider(vertical: false),
              FButton(
                onPress: () {},
                style: FButtonStyle.primary,
                label: const Text("Cambiar contraseña"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
