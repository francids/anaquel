import 'package:anaquel/logic/auth_bloc.dart';
import 'package:anaquel/logic/user_bloc.dart';
import 'package:anaquel/screens/auth/change_password_screen.dart';
import 'package:anaquel/screens/auth/edit_profile_screen.dart';
import 'package:anaquel/widgets/chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
          BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              if (state is UserLoading) {
                return const Column(
                  children: [
                    CircularProgressIndicator(),
                  ],
                );
              }
              if (state is UserError) {
                return Column(
                  children: [
                    FAlert(
                      icon: FAlertIcon(icon: FAssets.icons.badgeX),
                      title: const Text("Error al cargar usuario"),
                      subtitle: Text(state.message),
                      style: FAlertStyle.destructive,
                    ),
                  ],
                );
              }
              if (state is UserLoaded) {
                return Column(
                  children: [
                    FAvatar(
                      image: const NetworkImage(''),
                      size: 150,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      state.user.name,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "(${state.user.username}) - ${state.user.email}",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const SizedBox(height: 16),
                    FButton(
                      onPress: () => Navigator.of(context).push(
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  const EditProfileScreen(),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            return SlideTransition(
                              position: Tween<Offset>(
                                begin: const Offset(1, 0),
                                end: Offset.zero,
                              ).animate(animation),
                              child: child,
                            );
                          },
                        ),
                      ),
                      style: FButtonStyle.outline,
                      label: const Text("Editar perfil"),
                    ),
                    const SizedBox(height: 8),
                    FButton(
                      onPress: () => Navigator.of(context).push(
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  const ChangePasswordScreen(),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            return SlideTransition(
                              position: Tween<Offset>(
                                begin: const Offset(1, 0),
                                end: Offset.zero,
                              ).animate(animation),
                              child: child,
                            );
                          },
                        ),
                      ),
                      style: FButtonStyle.outline,
                      label: const Text("Cambiar contraseña"),
                    ),
                  ],
                );
              }
              return const SizedBox.shrink();
            },
          ),
          const SizedBox(height: 8),
          FButton(
            onPress: () => showAdaptiveDialog(
              context: context,
              builder: (context) => FDialog(
                direction: Axis.vertical,
                body: const Padding(
                  padding: EdgeInsets.only(bottom: 16),
                  child: Text(
                    "Elige el modo de colores a mostrar de la aplicación:",
                    textAlign: TextAlign.start,
                  ),
                ),
                actions: <FButton>[
                  FButton(
                    onPress: () => context.pop(),
                    style: FButtonStyle.outline,
                    label: const Text("Predeterminado"),
                  ),
                  FButton(
                    onPress: () => context.pop(),
                    style: FButtonStyle.outline,
                    label: const Text("Claro"),
                  ),
                  FButton(
                    onPress: () => context.pop(),
                    style: FButtonStyle.outline,
                    label: const Text("Oscuro"),
                  ),
                ],
              ),
            ),
            style: FButtonStyle.outline,
            label: const Text("Apariencia de la aplicación"),
          ),
          const SizedBox(height: 8),
          FButton(
            onPress: () => showAdaptiveDialog(
              context: context,
              builder: (context) => FDialog(
                direction: Axis.vertical,
                body: const Padding(
                  padding: EdgeInsets.only(bottom: 16),
                  child: Text(
                    "Elige el idioma a mostrar dentro de la aplicación",
                    textAlign: TextAlign.start,
                  ),
                ),
                actions: <FButton>[
                  FButton(
                    onPress: () => context.pop(),
                    style: FButtonStyle.outline,
                    label: const Text("Predeterminado"),
                  ),
                  FButton(
                    onPress: () => context.pop(),
                    style: FButtonStyle.outline,
                    label: const Text("Español"),
                  ),
                  FButton(
                    onPress: () => context.pop(),
                    style: FButtonStyle.outline,
                    label: const Text("Inglés"),
                  ),
                ],
              ),
            ),
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
            onPress: () => showAdaptiveDialog(
              context: context,
              builder: (context) => FDialog(
                direction: Axis.vertical,
                body: const Padding(
                  padding: EdgeInsets.only(bottom: 16),
                  child: Text(
                    "¿Estás seguro de que deseas cerrar sesión?",
                    textAlign: TextAlign.start,
                  ),
                ),
                actions: <FButton>[
                  FButton(
                    onPress: () => {
                      context.read<AuthBloc>().add(LogoutEvent()),
                      context.go('/login'),
                    },
                    style: FButtonStyle.destructive,
                    label: const Text("Cerrar sesión"),
                  ),
                  FButton(
                    onPress: () => context.pop(),
                    style: FButtonStyle.outline,
                    label: const Text("Cancelar"),
                  ),
                ],
              ),
            ),
            style: FButtonStyle.destructive,
            label: const Text("Cerrar sesión"),
          ),
        ],
      ),
    );
  }
}
