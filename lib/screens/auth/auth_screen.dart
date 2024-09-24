import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Color(0xFF941932),
      ),
    );

    return FTheme(
      data: FThemes.zinc.light,
      child: FScaffold(
        style: FScaffoldStyle(
          contentPadding: const EdgeInsets.all(16),
          footerDecoration: const BoxDecoration(),
          headerDecoration: const BoxDecoration(),
          backgroundColor: const Color(0xFF941932),
        ),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FButton(
              onPress: () {
                context.go('/');
              },
              style: FButtonStyle.primary,
              label: const Text("Iniciar sesión"),
            ),
          ],
        ),
      ),
    );
  }
}
