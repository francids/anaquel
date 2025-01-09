import 'package:anaquel/app/app.dart';
import 'package:anaquel/utils/notifications.dart';
import 'package:anaquel/constants/system_ui_config.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:scaled_app/scaled_app.dart';

Future<void> main() async {
  await _initializeApp();
  runApp(_buildLocalizedApp());
}

Future<void> _initializeApp() async {
  ScaledWidgetsFlutterBinding.ensureInitialized(scaleFactor: (_) => 1.0);
  await initializeNotifications();
  await dotenv.load(fileName: ".env", isOptional: true);
  EasyLocalization.logger.enableBuildModes = [];
  await EasyLocalization.ensureInitialized();
  configureSystemUI();
}

Widget _buildLocalizedApp() {
  return EasyLocalization(
    path: "assets/translations",
    supportedLocales: const [Locale("es"), Locale("en")],
    fallbackLocale: const Locale("es"),
    child: const AnaquelApp(),
  );
}
