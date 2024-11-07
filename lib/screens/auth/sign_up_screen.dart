import 'package:anaquel/logic/auth_bloc.dart';
import 'package:anaquel/data/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

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
            FHeader.nested(
              title: const Text("Crear cuenta"),
              leftActions: [
                FHeaderAction.back(
                  onPress: () => context.pop(),
                ),
              ],
            ),
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is AuthLoading) {
                  return const LinearProgressIndicator();
                }
                return const SizedBox.shrink();
              },
            )
          ],
        ),
        contentPad: true,
        content: SingleChildScrollView(
          padding: EdgeInsets.only(
            top: 16,
            left: 16,
            right: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16,
          ),
          child: Column(
            children: [
              FTextField(
                controller: usernameController,
                label: const Text('Nombre de usuario'),
                autofillHints: const [AutofillHints.username],
                keyboardType: TextInputType.text,
                maxLines: 1,
              ),
              const SizedBox(height: 16),
              FTextField(
                controller: nameController,
                label: const Text('Nombre'),
                autofillHints: const [AutofillHints.name],
                keyboardType: TextInputType.name,
                maxLines: 1,
              ),
              const SizedBox(height: 16),
              FTextField(
                controller: emailController,
                label: const Text('Correo electrónico'),
                autofillHints: const [AutofillHints.email],
                keyboardType: TextInputType.emailAddress,
                maxLines: 1,
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
              FTextField(
                controller: confirmPasswordController,
                label: const Text('Confirmar contraseña'),
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
                  if (passwordController.text !=
                      confirmPasswordController.text) {
                    return;
                  }
                  final user = User(
                    name: nameController.text,
                    email: emailController.text,
                    username: usernameController.text,
                    password: passwordController.text,
                  );
                  context.read<AuthBloc>().add(SignUpEvent(user));
                },
                style: FButtonStyle.primary,
                label: const Text("Crear cuenta"),
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
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
