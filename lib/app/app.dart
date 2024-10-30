import 'package:anaquel/app/providers.dart';
import 'package:anaquel/app/router.dart';
import 'package:anaquel/app/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scaled_app/scaled_app.dart';

class AnaquelApp extends StatelessWidget {
  const AnaquelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: blocProviders(context),
      child: MaterialApp.router(
        title: "Anaquel",
        locale: const Locale('es'),
        debugShowCheckedModeBanner: false,
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).scale(),
            child: AnaquelTheme(child!),
          );
        },
        routerConfig: appRouter,
      ),
    );
  }
}
