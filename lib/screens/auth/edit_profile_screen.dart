import 'package:anaquel/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:scaled_app/scaled_app.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).scale(),
      child: FTheme(
        data: FThemes.zinc.light,
        child: FScaffold(
          header: Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withOpacity(0.1),
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: FHeader.nested(
              title: Text("Editar perfil"),
              leftActions: [
                FHeaderAction.back(onPress: () => context.pop()),
              ],
            ),
          ),
          contentPad: false,
          content: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                FAvatar(
                  image: const NetworkImage(''),
                  size: 150,
                ),
                const SizedBox(height: 8),
                const FTextField(
                  label: Text("Nombre"),
                  maxLines: 1,
                  autofillHints: [AutofillHints.name],
                  keyboardType: TextInputType.name,
                ),
                const SizedBox(height: 16),
                const FTextField(
                  label: Text("Correo electrónico"),
                  maxLines: 1,
                  autofillHints: [AutofillHints.email],
                  keyboardType: TextInputType.emailAddress,
                ),
                const FDivider(),
                FButton(
                  onPress: () => context.pop(),
                  style: FButtonStyle.primary,
                  label: const Text("Editar perfil"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
