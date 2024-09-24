import 'package:anaquel/widgets/chip.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static final List<String> _favoritesGenres = [
    'Ciencia ficción',
    'Fantasía',
    'Terror',
    'Romance',
    'Aventura',
    'Misterio',
    'Drama',
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          FAvatar(
            image: const NetworkImage(''),
            size: 150,
          ),
          const SizedBox(height: 8),
          const Text(
            "Francisco Mesa",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          FButton(
            onPress: () {},
            style: FButtonStyle.outline,
            label: const Text("Editar perfil"),
          ),
          const SizedBox(height: 8),
          FButton(
            onPress: () {},
            style: FButtonStyle.outline,
            label: const Text("Cambiar contraseña"),
          ),
          const SizedBox(height: 8),
          FButton(
            onPress: () {},
            style: FButtonStyle.outline,
            label: const Text("Apariencia de la aplicación"),
          ),
          const SizedBox(height: 8),
          FButton(
            onPress: () {},
            style: FButtonStyle.outline,
            label: const Text("Idioma de la aplicación"),
          ),
          const FDivider(vertical: false),
          const SizedBox(
            width: double.infinity,
            child: Text(
              "Géneros favoritos",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: Wrap(
              alignment: WrapAlignment.start,
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final genre in _favoritesGenres) AChip(label: genre),
              ],
            ),
          ),
          const FDivider(vertical: false),
          FButton(
            onPress: () => context.go('/auth'),
            style: FButtonStyle.destructive,
            label: const Text("Cerrar sesión"),
          ),
        ],
      ),
    );
  }
}
