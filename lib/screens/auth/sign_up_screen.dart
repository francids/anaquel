import 'package:anaquel/data/models/user.dart';
import 'package:anaquel/data/services/auth_service.dart';
import 'package:anaquel/logic/auth_bloc.dart';
import 'package:anaquel/screens/auth/verification_code_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool _isLoading = false;

  goToVerificationCodeScreen(BuildContext context, String verificationCode) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            VerificationCodeScreen(
          verificationCode: verificationCode,
          user: User(
            name: nameController.text,
            email: emailController.text,
            username: usernameController.text,
            password: passwordController.text,
          ),
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 1),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final AuthService authService = AuthService();

    return Stack(
      children: [
        FScaffold(
          header: Column(
            children: [
              FHeader.nested(
                title: const Text(
                  "auth_screens.sign_up_screen.sign_up",
                ).tr(),
                prefixActions: [
                  FHeaderAction.back(
                    onPress: () => context.pop(),
                  ),
                ],
                suffixActions: [
                  FHeaderAction(
                    icon: FAssets.icons.languages(),
                    onPress: () {
                      context.setLocale(
                        context.locale == const Locale("en")
                            ? const Locale("es")
                            : const Locale("en"),
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
                    controller: usernameController,
                    label: const Text(
                      "auth_screens.sign_up_screen.username",
                    ).tr(),
                    autofillHints: const [AutofillHints.username],
                    keyboardType: TextInputType.text,
                    maxLines: 1,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "auth_screens.sign_up_screen.error.empty_field"
                            .tr();
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  FTextField(
                    controller: nameController,
                    label: const Text(
                      "auth_screens.sign_up_screen.name",
                    ).tr(),
                    autofillHints: const [AutofillHints.name],
                    keyboardType: TextInputType.name,
                    maxLines: 1,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "auth_screens.sign_up_screen.error.empty_field"
                            .tr();
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  FTextField(
                    controller: emailController,
                    label: const Text(
                      "auth_screens.sign_up_screen.email",
                    ).tr(),
                    autofillHints: const [AutofillHints.email],
                    keyboardType: TextInputType.emailAddress,
                    maxLines: 1,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "auth_screens.sign_up_screen.error.empty_field"
                            .tr();
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  FTextField(
                    controller: passwordController,
                    label: const Text(
                      "auth_screens.sign_up_screen.password",
                    ).tr(),
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    maxLines: 1,
                    autofillHints: const [AutofillHints.password],
                    keyboardType: TextInputType.visiblePassword,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "auth_screens.sign_up_screen.error.empty_field"
                            .tr();
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  FTextField(
                    controller: confirmPasswordController,
                    label: const Text(
                      "auth_screens.sign_up_screen.confirm_password",
                    ).tr(),
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    maxLines: 1,
                    autofillHints: const [AutofillHints.password],
                    keyboardType: TextInputType.visiblePassword,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "auth_screens.sign_up_screen.error.empty_field"
                            .tr();
                      }
                      if (value != passwordController.text) {
                        return "auth_screens.sign_up_screen.error.password_mismatch"
                            .tr();
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  FButton(
                    onPress: () async {
                      if (!_formKey.currentState!.validate()) {
                        return;
                      }
                      setState(() {
                        _isLoading = true;
                      });
                      try {
                        String verificationCode = await authService
                            .getVerificationCode(emailController.text);
                        goToVerificationCodeScreen(context, verificationCode);
                      } catch (e) {
                        debugPrint(e.toString());
                      } finally {
                        setState(() {
                          _isLoading = false;
                        });
                      }
                    },
                    style: FButtonStyle.primary,
                    label: const Text(
                      "auth_screens.sign_up_screen.sign_up",
                    ).tr(),
                  ),
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      if (state is AuthFailure) {
                        return Column(
                          children: [
                            const SizedBox(height: 16),
                            FAlert(
                              icon: FAssets.icons.badgeX(),
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
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
        if (_isLoading)
          const ModalBarrier(dismissible: false, color: Colors.black54),
        if (_isLoading) const Center(child: CircularProgressIndicator()),
      ],
    );
  }
}
