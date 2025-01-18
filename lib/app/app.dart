import 'package:anaquel/app/providers.dart';
import 'package:anaquel/app/router.dart';
import 'package:anaquel/app/theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/localizations.dart';
import 'package:scaled_app/scaled_app.dart';

class AnaquelApp extends StatelessWidget {
  const AnaquelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: Providers.blocs(),
      child: MaterialApp.router(
        title: "Anaquel",
        localizationsDelegates: [
          ...context.localizationDelegates,
          FLocalizations.delegate,
        ],
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
        theme: anaquelMaterialTheme(),
        builder: (context, child) => _buildScaledApp(context, child),
        routerConfig: appRouter,
      ),
    );
  }

  Widget _buildScaledApp(BuildContext context, Widget? child) {
    return MediaQuery(
      data: MediaQuery.of(context).scale(),
      child: AnaquelTheme(child!),
    );
  }
}
