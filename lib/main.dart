import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:scaled_app/scaled_app.dart';
import 'package:anaquel/app/app.dart';
import 'package:anaquel/constants/system_ui_config.dart';

Future<void> main() async {
  ScaledWidgetsFlutterBinding.ensureInitialized(scaleFactor: (_) => 1.0);
  configureSystemUI();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      path: 'assets/translations',
      supportedLocales: const [Locale('es'), Locale('en')],
      fallbackLocale: const Locale('es'),
      child: const AnaquelApp(),
    ),
  );
}
