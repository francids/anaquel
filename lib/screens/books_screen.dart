import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

class BooksScreen extends StatelessWidget {
  const BooksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const SizedBox(
            width: double.infinity,
            child: Text(
              "Colecciones",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 16),
          FButton(
            onPress: () {},
            style: FButtonStyle.outline,
            label: const Text("Crear colección"),
          ),
          const FDivider(),
          FButton(
            onPress: () {},
            style: FButtonStyle.primary,
            label: const Text("Registrar libro"),
          ),
          const SizedBox(height: 16),
          const SizedBox(
            width: double.infinity,
            child: Text(
              "Libros en ninguna colección",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
