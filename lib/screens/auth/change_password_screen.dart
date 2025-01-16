import 'package:anaquel/logic/auth_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmNewPasswordController =
      TextEditingController();

  bool _isLoading = false;
  bool _obscureOldPassword = true;
  bool _obscureNewPassword = true;
  bool _obscureNewConfirmPassword = true;
  bool _alreadySubmitted = false;

  Future<void> submit() async {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    _alreadySubmitted = true;

    _changePassword();

    if (!context.mounted) return;

    setState(() => _isLoading = false);
  }

  void _changePassword() {
    context.read<AuthBloc>().add(
          ChangePasswordEvent(
            oldPasswordController.text,
            newPasswordController.text,
          ),
        );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return FDialog(
          body: Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: const Text(
              "auth_screens.change_password_screen.success",
            ).tr(),
          ),
          actions: [
            FButton(
              label: const Text(
                "auth_screens.change_password_screen.ok",
              ).tr(),
              style: FButtonStyle.outline,
              onPress: () {
                dialogContext.pop();
                context.read<AuthBloc>().add(LogoutEvent());
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _alreadySubmitted = false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthInitial) {
          _showSuccessDialog();
        }
      },
      child: FScaffold(
        header: FHeader.nested(
          title: const Text(
            "auth_screens.change_password_screen.title",
          ).tr(),
          prefixActions: [
            FHeaderAction.back(
              onPress: () => context.pop(),
            ),
          ],
        ),
        contentPad: false,
        content: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                FAlert(
                  title: const Text(
                    "auth_screens.change_password_screen.warning",
                  ).tr(),
                  subtitle: const Text(
                    "auth_screens.change_password_screen.warning_description",
                  ).tr(),
                  icon: FIcon(FAssets.icons.badgeAlert),
                ),
                const FDivider(),
                FTextField.password(
                  controller: oldPasswordController,
                  obscureText: _obscureOldPassword,
                  label: const Text(
                    "auth_screens.change_password_screen.current_password",
                  ).tr(),
                  suffix: FButton.icon(
                    focusNode: FocusNode(canRequestFocus: false),
                    style: FButtonStyle.ghost,
                    child: Padding(
                      padding: const EdgeInsets.all(6),
                      child: FIcon(
                        (_obscureOldPassword)
                            ? FAssets.icons.eyeClosed
                            : FAssets.icons.eye,
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withAlpha(153),
                      ),
                    ),
                    onPress: () => setState(
                      () => _obscureOldPassword = !_obscureOldPassword,
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "auth_screens.sign_up_screen.error.empty_field"
                          .tr();
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                FTextField.password(
                  controller: newPasswordController,
                  obscureText: _obscureNewPassword,
                  label: const Text(
                    "auth_screens.change_password_screen.new_password",
                  ).tr(),
                  description: (newPasswordController.text.isEmpty)
                      ? const Text(
                          "auth_screens.sign_up_screen.password_description",
                        ).tr()
                      : null,
                  suffix: FButton.icon(
                    focusNode: FocusNode(canRequestFocus: false),
                    style: FButtonStyle.ghost,
                    child: Padding(
                      padding: const EdgeInsets.all(6),
                      child: FIcon(
                        (_obscureNewPassword)
                            ? FAssets.icons.eyeClosed
                            : FAssets.icons.eye,
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withAlpha(153),
                      ),
                    ),
                    onPress: () => setState(
                      () => _obscureNewPassword = !_obscureNewPassword,
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "auth_screens.sign_up_screen.error.empty_field"
                          .tr();
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
                  controller: confirmNewPasswordController,
                  obscureText: _obscureNewConfirmPassword,
                  label: const Text(
                    "auth_screens.change_password_screen.confirm_password",
                  ).tr(),
                  suffix: FButton.icon(
                    focusNode: FocusNode(canRequestFocus: false),
                    style: FButtonStyle.ghost,
                    child: Padding(
                      padding: const EdgeInsets.all(6),
                      child: FIcon(
                        (_obscureNewConfirmPassword)
                            ? FAssets.icons.eyeClosed
                            : FAssets.icons.eye,
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withAlpha(153),
                      ),
                    ),
                    onPress: () => setState(
                      () => _obscureNewConfirmPassword =
                          !_obscureNewConfirmPassword,
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "auth_screens.sign_up_screen.error.empty_field"
                          .tr();
                    }
                    if (value != newPasswordController.text) {
                      return "auth_screens.sign_up_screen.error.password_mismatch"
                          .tr();
                    }
                    return null;
                  },
                ),
                const FDivider(),
                FButton(
                  onPress: (_isLoading) ? null : submit,
                  style: FButtonStyle.primary,
                  prefix: (_isLoading) ? const FButtonSpinner() : null,
                  label: Text(
                    (_isLoading)
                        ? "auth_screens.change_password_screen.changing_password"
                            .tr()
                        : "auth_screens.change_password_screen.title".tr(),
                  ),
                ),
                const FDivider(),
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    if (state is AuthSuccess && _alreadySubmitted) {
                      return FAlert(
                        title: const Text(
                          "auth_screens.change_password_screen.error",
                        ).tr(),
                        subtitle: const Text(
                          "auth_screens.change_password_screen.error_description",
                        ).tr(),
                        style: FAlertStyle.destructive,
                        icon: FIcon(FAssets.icons.badgeAlert),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
