import 'package:anaquel/logic/auth_bloc.dart';
import 'package:anaquel/constants/colors.dart';
import 'package:anaquel/data/models/user.dart';
import 'package:anaquel/screens/auth/sign_up_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';

class LogInScreen extends StatelessWidget {
  LogInScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
            FHeader.nested(
              title: const Text(
                "auth_screens.log_in_screen.login",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 20,
                  height: 1,
                ),
              ).tr(),
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
                    "auth_screens.log_in_screen.username",
                  ).tr(),
                  maxLines: 1,
                  autofillHints: const [AutofillHints.username],
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "auth_screens.log_in_screen.error.empty_field"
                          .tr();
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                FTextField(
                  controller: passwordController,
                  label: const Text(
                    "auth_screens.log_in_screen.password",
                  ).tr(),
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  maxLines: 1,
                  autofillHints: const [AutofillHints.password],
                  keyboardType: TextInputType.visiblePassword,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "auth_screens.log_in_screen.error.empty_field"
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
                      name: '',
                      email: '',
                      username: usernameController.text,
                      password: passwordController.text,
                    );
                    context.read<AuthBloc>().add(LoginEvent(user));
                  },
                  style: FButtonStyle.primary,
                  label: const Text(
                    "auth_screens.log_in_screen.login",
                  ).tr(),
                ),
                BlocBuilder<AuthBloc, AuthState>(
                  buildWhen: (previous, current) =>
                      current is AuthFailure || current is AuthSuccess,
                  builder: (context, state) {
                    if (state is AuthFailure) {
                      return Column(
                        children: [
                          const SizedBox(height: 16),
                          FAlert(
                            icon: FIcon(FAssets.icons.badgeX),
                            title: Text(state.error).tr(),
                            style: FAlertStyle.destructive,
                          ),
                        ],
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
                const SizedBox(height: 8),
                const FDivider(),
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
                    child: Row(
                      children: [
                        const Text(
                          "auth_screens.log_in_screen.no_account.message",
                        ).tr(),
                        const Text(
                          "auth_screens.log_in_screen.no_account.sign_up",
                          style: TextStyle(
                            color: AppColors.burgundy,
                            fontWeight: FontWeight.bold,
                          ),
                        ).tr(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
