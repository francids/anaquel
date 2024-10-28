import 'package:anaquel/blocs/auth_bloc.dart';
import 'package:anaquel/constants/colors.dart';
import 'package:anaquel/data/models/user.dart';
import 'package:anaquel/screens/auth/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';

class LogInScreen extends StatelessWidget {
  LogInScreen({super.key});

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          context.go('/');
        }
      },
      child: FScaffold(
        header: Column(
          children: [
            const FHeader(
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
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is AuthLoading) {
                  return const LinearProgressIndicator(color: AppColors.night);
                }
                return const SizedBox.shrink();
              },
            )
          ],
        ),
        contentPad: true,
        content: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              FTextField(
                controller: usernameController,
                label: const Text('Nombre de usuario'),
                maxLines: 1,
                autofillHints: const [AutofillHints.username],
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 16),
              FTextField(
                controller: passwordController,
                label: const Text('Contraseña'),
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                maxLines: 1,
                autofillHints: const [AutofillHints.password],
                keyboardType: TextInputType.visiblePassword,
              ),
              const SizedBox(height: 16),
              FButton(
                onPress: () {
                  final user = User(
                    name: '',
                    email: '',
                    username: usernameController.text,
                    password: passwordController.text,
                  );
                  context.read<AuthBloc>().add(LoginEvent(user));
                },
                style: FButtonStyle.primary,
                label: const Text("Iniciar sesión"),
              ),
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  if (state is AuthFailure) {
                    return Column(
                      children: [
                        const SizedBox(height: 16),
                        FAlert(
                          icon: FAlertIcon(icon: FAssets.icons.badgeX),
                          title: const Text("Error al iniciar sesión"),
                          subtitle: const Text(
                            "Por favor, verifica tus credenciales e intenta de nuevo.",
                          ),
                          style: FAlertStyle.destructive,
                        ),
                      ],
                    );
                  }
                  return const SizedBox.shrink(
                    child: Text("Inicio de sesión exitoso"),
                  );
                },
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
                          SignUpScreen(),
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
      ),
    );
  }
}
