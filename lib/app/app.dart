import 'package:anaquel/app/router.dart';
import 'package:anaquel/app/theme.dart';
import 'package:anaquel/blocs/auth_bloc.dart';
import 'package:anaquel/data/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scaled_app/scaled_app.dart';

class AnaquelApp extends StatelessWidget {
  const AnaquelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(AuthService()),
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
