import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationApi {
  static final _notifications = FlutterLocalNotificationsPlugin();

  static Future init() async {
    const android = AndroidInitializationSettings("@mipmap/ic_launcher");
    const iOS = IOSInitializationSettings();
    const settings = InitializationSettings(android: android, iOS: iOS);
    _notifications.initialize(settings, onSelectNotification: (payload) {});
  }

  static Future<void> showBigTextNotification(
      {required String title, required String bigText}) async {
    // Customize the notification details
    BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
      bigText,
      // htmlFormatBigText: true,
      // contentTitle: 'overridden <b>big</b> content title',
      // htmlFormatContentTitle: true,
      // summaryText: 'summary <i>text</i>',
      // htmlFormatSummaryText: true,
    );
    final AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'botp big text channel id',
      'botp big text channel name',
      channelDescription: 'botp big text channel description',
      styleInformation: bigTextStyleInformation,
      importance: Importance.max,
      priority: Priority.high,
      enableLights: true,
      ledColor: Colors.white,
      visibility: NotificationVisibility.public,
    );

    // Notification details
    final NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    // Show notification with unique id
    await _notifications.show(
        DateTime.now().millisecondsSinceEpoch ~/ Duration.millisecondsPerSecond,
        title,
        bigText,
        platformChannelSpecifics);
  }
}
