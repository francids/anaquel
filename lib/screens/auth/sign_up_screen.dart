import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: FHeader.nested(
        title: const Text("Crear cuenta"),
        leftActions: [
          FHeaderAction.back(
            onPress: () => context.pop(),
          ),
        ],
      ),
      contentPad: true,
      content: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const FTextField(
              label: Text('Nombre'),
              autofillHints: [AutofillHints.name],
              keyboardType: TextInputType.name,
            ),
            const SizedBox(height: 16),
            const FTextField(
              label: Text('Correo electrónico'),
              autofillHints: [AutofillHints.email],
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            const FTextField(
              label: Text('Contraseña'),
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              maxLines: 1,
              autofillHints: [AutofillHints.password],
              keyboardType: TextInputType.visiblePassword,
            ),
            const SizedBox(height: 16),
            const FTextField(
              label: Text('Confirmar contraseña'),
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              maxLines: 1,
              autofillHints: [AutofillHints.password],
              keyboardType: TextInputType.visiblePassword,
            ),
            const SizedBox(height: 16),
            FButton(
              onPress: () {
                context.go('/');
              },
              style: FButtonStyle.primary,
              label: const Text("Crear cuenta"),
            ),
            const SizedBox(height: 8),
            const FDivider(vertical: false),
            const SizedBox(
              width: double.infinity,
              child: Text(
                "O puedes registrarte con:",
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
            const SizedBox(height: 16),
            FButton(
              prefix: SvgPicture.asset("assets/google_icon.svg"),
              onPress: () {},
              style: FButtonStyle.outline,
              label: const Text("Registrarse con Google"),
            ),
          ],
        ),
      ),
    );
  }
}
