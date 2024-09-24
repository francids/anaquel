import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

class SchedulesScreen extends StatelessWidget {
  const SchedulesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FButton(
          onPress: () {},
          style: FButtonStyle.primary,
          label: const Text("Crear hora de lectura"),
        ),
        const FDivider(),
      ],
    );
  }
}
