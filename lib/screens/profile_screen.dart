import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FButton(
          onPress: () => context.go('/auth'),
          style: FButtonStyle.destructive,
          label: const Text("Cerrar sesión"),
        )
      ],
    );
  }
}
