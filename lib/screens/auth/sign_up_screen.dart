import 'package:anaquel/logic/auth_bloc.dart';
import 'package:anaquel/data/models/user.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
              title: const Text("auth_screens.sign_up_screen.sign_up").tr(),
              leftActions: [
                FHeaderAction.back(
                  onPress: () => context.pop(),
                ),
              ],
              rightActions: [
                FHeaderAction(
                  icon: FAssets.icons.languages,
                  onPress: () {
                    context.setLocale(
                      context.locale == const Locale('en')
                          ? const Locale('es')
                          : const Locale('en'),
                    );
                  },
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
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                FTextField(
                  controller: usernameController,
                  label:
                      const Text('auth_screens.sign_up_screen.username').tr(),
                  autofillHints: const [AutofillHints.username],
                  keyboardType: TextInputType.text,
                  maxLines: 1,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'auth_screens.sign_up_screen.error.empty_field'
                          .tr();
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                FTextField(
                  controller: nameController,
                  label: const Text('auth_screens.sign_up_screen.name').tr(),
                  autofillHints: const [AutofillHints.name],
                  keyboardType: TextInputType.name,
                  maxLines: 1,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'auth_screens.sign_up_screen.error.empty_field'
                          .tr();
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                FTextField(
                  controller: emailController,
                  label: const Text("auth_screens.sign_up_screen.email").tr(),
                  autofillHints: const [AutofillHints.email],
                  keyboardType: TextInputType.emailAddress,
                  maxLines: 1,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'auth_screens.sign_up_screen.error.empty_field'
                          .tr();
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                FTextField(
                  controller: passwordController,
                  label:
                      const Text('auth_screens.sign_up_screen.password').tr(),
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  maxLines: 1,
                  autofillHints: const [AutofillHints.password],
                  keyboardType: TextInputType.visiblePassword,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'auth_screens.sign_up_screen.error.empty_field'
                          .tr();
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                FTextField(
                  controller: confirmPasswordController,
                  label: const Text(
                    'auth_screens.sign_up_screen.confirm_password',
                  ).tr(),
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  maxLines: 1,
                  autofillHints: const [AutofillHints.password],
                  keyboardType: TextInputType.visiblePassword,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'auth_screens.sign_up_screen.error.empty_field'
                          .tr();
                    }
                    if (value != passwordController.text) {
                      return 'auth_screens.sign_up_screen.error.password_mismatch'
                          .tr();
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                FButton(
                  onPress: () {
                    if (!_formKey.currentState!.validate()) {
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
                  label: const Text("auth_screens.sign_up_screen.sign_up").tr(),
                ),
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    if (state is AuthFailure) {
                      return Column(
                        children: [
                          const SizedBox(height: 16),
                          FAlert(
                            icon: FAlertIcon(icon: FAssets.icons.badgeX),
                            title: const Text(
                              "auth_screens.sign_up_screen.error.title",
                            ).tr(),
                            subtitle: const Text(
                              "auth_screens.sign_up_screen.error.message",
                            ).tr(),
                            style: FAlertStyle.destructive,
                          ),
                        ],
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
                const SizedBox(height: 8),
                const FDivider(vertical: false),
                SizedBox(
                  width: double.infinity,
                  child: const Text(
                    "auth_screens.sign_up_screen.other_options.message",
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ).tr(),
                ),
                const SizedBox(height: 16),
                FButton(
                  prefix: SvgPicture.asset("assets/google_icon.svg"),
                  onPress: () {},
                  style: FButtonStyle.outline,
                  label: const Text(
                    "auth_screens.sign_up_screen.other_options.google",
                  ).tr(),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
