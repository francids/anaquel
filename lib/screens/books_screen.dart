import 'package:anaquel/widgets/collection_chip.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';

List<String> _collections = [
  "Colección 01",
  "Colección 02",
  "Colección 03",
  "Colección 04",
  "Colección 05",
];

List<String> _collectionsColors = [
  "#FF8707",
  "#FF5722",
  "#E91E63",
  "#9C27B0",
  "#3F51B5",
];

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
          SizedBox(
            width: double.infinity,
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List.generate(
                _collections.length,
                (index) {
                  return SizedBox(
                    width: MediaQuery.of(context).size.width / 2 - 24,
                    child: CollectionChip(
                      label: _collections[index],
                      color: Color(
                        int.parse(
                              _collectionsColors[index].substring(1),
                              radix: 16,
                            ) +
                            0xFF000000,
                      ),
                      onPress: () => context.push(
                        "/collection/$index",
                        extra: _collections[index],
                      ),
                    ),
                  );
                },
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
