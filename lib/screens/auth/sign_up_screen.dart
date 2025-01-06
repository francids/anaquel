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
  final AuthService authService = AuthService();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  Future<void> submit() async {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);

    final email = emailController.text;
    NavigatorState navigator = Navigator.of(context);

    try {
      String verificationCode = await authService.getVerificationCode(email);
      goToVerificationCodeScreen(navigator, verificationCode);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void goToVerificationCodeScreen(
    NavigatorState navigator,
    String verificationCode,
  ) {
    final user = User(
      name: nameController.text,
      email: emailController.text,
      username: usernameController.text,
      password: passwordController.text,
    );
    navigator.push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return VerificationCodeScreen(
            verificationCode: verificationCode,
            user: user,
          );
        },
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
    return FScaffold(
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
          if (_isLoading) const LinearProgressIndicator(),
        ],
      ),
      resizeToAvoidBottomInset: true,
      contentPad: false,
      content: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
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
                    return "auth_screens.sign_up_screen.error.empty_field".tr();
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
                    return "auth_screens.sign_up_screen.error.empty_field".tr();
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              FTextField.email(
                controller: emailController,
                label: const Text(
                  "auth_screens.sign_up_screen.email",
                ).tr(),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "auth_screens.sign_up_screen.error.empty_field".tr();
                  }
                  if (!RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$')
                      .hasMatch(value)) {
                    return "auth_screens.sign_up_screen.error.invalid_email"
                        .tr();
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              FTextField.password(
                controller: passwordController,
                obscureText: _obscurePassword,
                label: const Text(
                  "auth_screens.sign_up_screen.password",
                ).tr(),
                description: (passwordController.text.isEmpty)
                    ? const Text(
                        "auth_screens.sign_up_screen.password_description",
                      ).tr()
                    : null,
                suffix: FButton.icon(
                  style: FButtonStyle.ghost,
                  child: Padding(
                    padding: const EdgeInsets.all(6),
                    child: FIcon(
                      (_obscurePassword)
                          ? FAssets.icons.eyeClosed
                          : FAssets.icons.eye,
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withAlpha(153),
                    ),
                  ),
                  onPress: () => setState(
                    () => _obscurePassword = !_obscurePassword,
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "auth_screens.sign_up_screen.error.empty_field".tr();
                  }
                  if (value.length < 8) {
                    return "auth_screens.sign_up_screen.error.password_length"
                        .tr();
                  }
                  if (!RegExp(
                    r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$&*~])',
                  ).hasMatch(value)) {
                    return "auth_screens.sign_up_screen.error.password_complexity"
                        .tr();
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              FTextField.password(
                controller: confirmPasswordController,
                obscureText: _obscureConfirmPassword,
                label: const Text(
                  "auth_screens.sign_up_screen.confirm_password",
                ).tr(),
                suffix: FButton.icon(
                  style: FButtonStyle.ghost,
                  child: Padding(
                    padding: const EdgeInsets.all(6),
                    child: FIcon(
                      (_obscureConfirmPassword)
                          ? FAssets.icons.eyeClosed
                          : FAssets.icons.eye,
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withAlpha(153),
                    ),
                  ),
                  onPress: () => setState(
                    () => _obscureConfirmPassword = !_obscureConfirmPassword,
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "auth_screens.sign_up_screen.error.empty_field".tr();
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
                onPress: (!_isLoading) ? submit : null,
                style: FButtonStyle.primary,
                prefix: (_isLoading) ? const FButtonSpinner() : null,
                label: Text(
                  (_isLoading)
                      ? "auth_screens.verification_code_screen.request"
                      : "auth_screens.sign_up_screen.sign_up",
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
    );
  }
}
