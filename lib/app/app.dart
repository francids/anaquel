import 'package:anaquel/app/router.dart';
import 'package:anaquel/app/theme.dart';
import 'package:flutter/material.dart';
import 'package:scaled_app/scaled_app.dart';

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "Anaquel",
      locale: const Locale('es'),
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).scale(),
          child: AFTheme(child: child!),
        );
      },
      routerConfig: appRouter,
    );
  }
}
