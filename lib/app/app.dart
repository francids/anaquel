import 'package:anaquel/app/router.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:scaled_app/scaled_app.dart';

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "Anaquel",
      locale: const Locale('es'),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Inter',
      ),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).scale(),
          child: FTheme(
            data: FThemes.zinc.light,
            child: child!,
          ),
        );
      },
      routerConfig: appRouter,
    );
  }
}
