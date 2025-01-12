import 'package:anaquel/data/models/user.dart';
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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  Future submit() async {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;

    if (widget.oldUser.username == _usernameController.text &&
        widget.oldUser.name == _nameController.text &&
        widget.oldUser.email == _emailController.text) {
      showNoChangesDialog();
      return;
    }
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

  @override
  void initState() {
    _usernameController.text = widget.oldUser.username;
    _nameController.text = widget.oldUser.name;
    _emailController.text = widget.oldUser.email;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FScaffold(
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
                    FTextField(
                      controller: _usernameController,
                      label: const Text(
                        "auth_screens.sign_up_screen.username",
                      ).tr(),
                      maxLines: 1,
                      autofillHints: const [AutofillHints.newUsername],
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
                      onPress: submit,
                      style: FButtonStyle.primary,
                      label: const Text(
                        "auth_screens.edit_profile_screen.save",
                      ).tr(),
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
    );
  }
}
