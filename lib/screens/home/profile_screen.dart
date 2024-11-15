import 'package:anaquel/logic/auth_bloc.dart';
import 'package:anaquel/logic/user_bloc.dart';
import 'package:anaquel/screens/auth/change_password_screen.dart';
import 'package:anaquel/screens/auth/edit_profile_screen.dart';
import 'package:anaquel/widgets/chip.dart';
import 'package:easy_localization/easy_localization.dart';
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
                      icon: FAssets.icons.badgeX(),
                      title: const Text("profile_screen.error").tr(),
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
                    FTileGroup(
                      children: [
                        FTile(
                          onPress: () => Navigator.of(context).push(
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      const EditProfileScreen(),
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
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
                          prefixIcon: FIcon(FAssets.icons.user),
                          title: const Text("profile_screen.edit_profile").tr(),
                          suffixIcon: FIcon(FAssets.icons.chevronRight),
                        ),
                        FTile(
                          onPress: () => Navigator.of(context).push(
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      const ChangePasswordScreen(),
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
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
                          prefixIcon: FIcon(FAssets.icons.lock),
                          title:
                              const Text("profile_screen.change_password").tr(),
                          suffixIcon: FIcon(FAssets.icons.chevronRight),
                        ),
                      ],
                    ),
                  ],
                );
              }
              return const SizedBox.shrink();
            },
          ),
          // const SizedBox(height: 12),
          const FDivider(),
          FTile(
            onPress: () => showAdaptiveDialog(
              context: context,
              builder: (context) => FDialog(
                direction: Axis.vertical,
                body: Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: const Text(
                    "profile_screen.change_language.message",
                    textAlign: TextAlign.start,
                  ).tr(),
                ),
                actions: <FButton>[
                  FButton(
                    onPress: () {
                      context.setLocale(const Locale('es'));
                      context.pop();
                    },
                    style: FButtonStyle.outline,
                    label: const Text("profile_screen.change_language.spanish")
                        .tr(),
                  ),
                  FButton(
                    onPress: () {
                      context.setLocale(const Locale('en'));
                      context.pop();
                    },
                    style: FButtonStyle.outline,
                    label: const Text("profile_screen.change_language.english")
                        .tr(),
                  ),
                ],
              ),
            ),
            prefixIcon: FIcon(FAssets.icons.languages),
            title: const Text("profile_screen.change_language.title").tr(),
            details: Text(
              context.locale.languageCode == "es"
                  ? "profile_screen.change_language.spanish".tr()
                  : "profile_screen.change_language.english".tr(),
            ),
            suffixIcon: FIcon(FAssets.icons.chevronRight),
          ),
          const FDivider(),
          SizedBox(
            width: double.infinity,
            child: const Text(
              "profile_screen.favorite_genres",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ).tr(),
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
          const FDivider(),
          FButton(
            onPress: () => showAdaptiveDialog(
              context: context,
              builder: (context) => FDialog(
                direction: Axis.vertical,
                body: Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: const Text(
                    "profile_screen.logout.message",
                    textAlign: TextAlign.start,
                  ).tr(),
                ),
                actions: <FButton>[
                  FButton(
                    onPress: () => {
                      context.read<AuthBloc>().add(LogoutEvent()),
                      context.go('/login'),
                    },
                    style: FButtonStyle.destructive,
                    label: const Text("profile_screen.logout.title").tr(),
                  ),
                  FButton(
                    onPress: () => context.pop(),
                    style: FButtonStyle.outline,
                    label: const Text("profile_screen.logout.cancel").tr(),
                  ),
                ],
              ),
            ),
            style: FButtonStyle.destructive,
            label: const Text("profile_screen.logout.title").tr(),
          ),
        ],
      ),
    );
  }
}
