import 'package:anaquel/data/models/user.dart';
import 'package:anaquel/data/services/auth_service.dart';
import 'package:anaquel/logic/auth_bloc.dart';
import 'package:anaquel/logic/user_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key, required this.oldUser});

  final User oldUser;

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final AuthService authService = AuthService();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  bool _isLoading = false;
  bool _isUsernameAvailable = true;

  Future submit() async {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    if (widget.oldUser.username == _usernameController.text &&
        widget.oldUser.name == _nameController.text &&
        widget.oldUser.email == _emailController.text) {
      setState(() => _isLoading = false);
      showNoChangesDialog();
      return;
    }

    editUser();

    if (!context.mounted) return;

    setState(() => _isLoading = false);
  }

  void editUser() {
    context.read<AuthBloc>().add(
          EditUserEvent(
            User(
              username: _usernameController.text,
              name: _nameController.text,
              email: _emailController.text,
            ),
          ),
        );
  }

  void showNoChangesDialog() {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return FDialog(
          title: const Text(
            "auth_screens.edit_profile_screen.no_changes",
          ).tr(),
          body: Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: const Text(
              "auth_screens.edit_profile_screen.no_changes_body",
            ).tr(),
          ),
          actions: [
            FButton(
              onPress: () => dialogContext.pop(),
              style: FButtonStyle.outline,
              label: const Text(
                "auth_screens.edit_profile_screen.ok",
              ).tr(),
            ),
          ],
        );
      },
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
              "auth_screens.edit_profile_screen.success",
            ).tr(),
          ),
          actions: [
            FButton(
              label: const Text(
                "auth_screens.edit_profile_screen.ok",
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
    _usernameController.text = widget.oldUser.username;
    _nameController.text = widget.oldUser.name;
    _emailController.text = widget.oldUser.email;
    super.initState();
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
            "auth_screens.edit_profile_screen.title",
          ).tr(),
          prefixActions: [
            FHeaderAction.back(onPress: () => context.pop()),
          ],
        ),
        contentPad: false,
        content: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserLoading) {
              return const Column(
                children: [
                  CircularProgressIndicator(),
                ],
              );
            }
            if (state is UserLoaded) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      FAlert(
                        title: const Text(
                          "auth_screens.edit_profile_screen.warning",
                        ).tr(),
                        subtitle: const Text(
                          "auth_screens.edit_profile_screen.warning_description",
                        ).tr(),
                        icon: FIcon(FAssets.icons.badgeAlert),
                      ),
                      const FDivider(),
                      FTextField(
                        controller: _usernameController,
                        label: const Text(
                          "auth_screens.sign_up_screen.username",
                        ).tr(),
                        description: (_usernameController.text.isEmpty ||
                                _usernameController.text ==
                                    widget.oldUser.username)
                            ? null
                            : (_isUsernameAvailable)
                                ? Row(
                                    children: [
                                      FIcon(
                                        FAssets.icons.circleCheck,
                                        color: Colors.green.shade900,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        "auth_screens.sign_up_screen.username_non_taken",
                                        style: TextStyle(
                                            color: Colors.green.shade900),
                                      ).tr(),
                                    ],
                                  )
                                : Row(
                                    children: [
                                      FIcon(
                                        FAssets.icons.circleX,
                                        color: Colors.red.shade900,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        "auth_screens.sign_up_screen.error.username_taken",
                                        style: TextStyle(
                                            color: Colors.red.shade900),
                                      ).tr(),
                                    ],
                                  ),
                        maxLines: 1,
                        autofillHints: const [AutofillHints.newUsername],
                        onChange: (value) {
                          authService.usernameExists(value.toLowerCase()).then(
                            (exists) {
                              setState(() => _isUsernameAvailable = !exists);
                            },
                          );
                        },
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
                        controller: _nameController,
                        label: const Text(
                          "auth_screens.sign_up_screen.name",
                        ).tr(),
                        maxLines: 1,
                        autofillHints: const [AutofillHints.name],
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "auth_screens.sign_up_screen.error.empty_field"
                                .tr();
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      FTextField.email(
                        controller: _emailController,
                        label: const Text(
                          "auth_screens.sign_up_screen.email",
                        ).tr(),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "auth_screens.sign_up_screen.error.empty_field"
                                .tr();
                          }
                          if (!RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$')
                              .hasMatch(value)) {
                            return "auth_screens.sign_up_screen.error.invalid_email"
                                .tr();
                          }
                          return null;
                        },
                      ),
                      const FDivider(),
                      FButton(
                        onPress: (!_isLoading && _isUsernameAvailable)
                            ? submit
                            : null,
                        style: FButtonStyle.primary,
                        prefix: (_isLoading) ? const FButtonSpinner() : null,
                        label: Text(
                          (_isLoading)
                              ? "auth_screens.edit_profile_screen.changing".tr()
                              : "auth_screens.edit_profile_screen.title".tr(),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
