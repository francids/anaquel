import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FButton(
          onPress: () {},
          style: FButtonStyle.destructive,
          label: const Text("Cerrar sesión"),
        )
      ],
    );
  }
}
