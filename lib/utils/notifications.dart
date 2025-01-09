import 'package:awesome_notifications/awesome_notifications.dart';

Future<void> initializeNotifications() async {
  AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
        channelKey: "scheduled",
        channelName: "Notificaciones programadas",
        channelDescription: "Notificaciones programadas",
      ),
    ],
  );
}
