import 'package:anaquel/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:scaled_app/scaled_app.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).scale(),
      child: FTheme(
        data: FThemes.zinc.light,
        child: FScaffold(
          header: Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withOpacity(0.1),
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: FHeader.nested(
              title: const Text(
                "Crear cuenta",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.eerieBlack,
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                ),
              ),
              leftActions: [
                FHeaderAction.back(
                  onPress: () => context.pop(),
                ),
              ],
            ),
          ),
          contentPad: true,
          content: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const SizedBox(height: 8),
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
                      color: AppColors.eerieBlack,
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
        ),
      ),
    );
  }
}
