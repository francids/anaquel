import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:scaled_app/scaled_app.dart';
import 'package:anaquel/app/app.dart';
import 'package:anaquel/constants/system_ui_config.dart';

Future<void> main() async {
  ScaledWidgetsFlutterBinding.ensureInitialized(scaleFactor: (_) => 1.0);
  AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
        channelKey: "scheduled",
        channelName: "Notificaciones programadas",
        channelDescription: "Notificaciones programadas",
      ),
    ],
    debug: true,
  );
  await dotenv.load(fileName: ".env");
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
