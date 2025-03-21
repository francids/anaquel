import 'package:anaquel/logic/auth_bloc.dart';
import 'package:anaquel/screens/faq_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';

class ProfileScreen extends StatelessWidget {
  final VoidCallback onLanguageChanged;

  const ProfileScreen({super.key, required this.onLanguageChanged});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      shrinkWrap: true,
      children: [
        BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthInitial) {
              return Column(
                children: [
                  FButton(
                    onPress: () =>
                        context.read<AuthBloc>().add(SignInWithGoogleEvent()),
                    label: const Text('Iniciar sesión con Google').tr(),
                  ),
                ],
              );
            }
            if (state is AuthLoading) {
              return Column(
                children: [
                  CircularProgressIndicator(),
                ],
              );
            }
            if (state is AuthSuccess) {
              return GestureDetector(
                onTap: () => context.read<AuthBloc>().add(SignOutEvent()),
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        state.user.name,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        state.user.email,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            if (state is AuthFailure) {
              return Column(
                children: [
                  FAlert(
                    icon: FAssets.icons.badgeX(),
                    title: const Text("profile_screen.error").tr(),
                    subtitle: Text(state.error),
                    style: FAlertStyle.destructive,
                  ),
                ],
              );
            }
            return SizedBox.shrink();
          },
        ),
        const SizedBox(height: 16),
        FCard.raw(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "principal_screen.help",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                  ),
                ).tr(),
                FButton.icon(
                  onPress: () => Navigator.of(context).push(
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const FaqScreen(),
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
                  child: FIcon(FAssets.icons.chevronRight),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
