import 'package:anaquel/constants/colors.dart';
import 'package:anaquel/screens/auth/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';

class LogInScreen extends StatelessWidget {
  const LogInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: const FHeader(
        title: Text(
          "Iniciar sesión",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 20,
            height: 1,
          ),
        ),
      ),
      contentPad: true,
      content: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
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
            FButton(
              onPress: () {
                context.go('/');
              },
              style: FButtonStyle.primary,
              label: const Text("Iniciar sesión"),
            ),
            const SizedBox(height: 8),
            const FDivider(vertical: false),
            const SizedBox(
              width: double.infinity,
              child: Text(
                "O puedes iniciar sesión con:",
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
              label: const Text("Continuar con Google"),
            ),
            const SizedBox(height: 8),
            const FDivider(vertical: false),
            SizedBox(
              width: double.infinity,
              child: GestureDetector(
                onTap: () => Navigator.of(context).push(
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const SignUpScreen(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      return SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0, 1),
                          end: Offset.zero,
                        ).animate(animation),
                        child: child,
                      );
                    },
                  ),
                ),
                child: const Row(
                  children: [
                    Text("¿No tienes una cuenta? "),
                    Text(
                      "Crear cuenta",
                      style: TextStyle(
                        color: AppColors.burgundy,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
