import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  NotificationService._internal();

  static final NotificationService _notificationService =
      NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }
  final FlutterLocalNotificationsPlugin flutterLocalNotificationPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    var initializationSettingAndroid =
        AndroidInitializationSettings('shopping_app');
    var initializationSettingIOS = IOSInitializationSettings(
      defaultPresentAlert: false,
      defaultPresentBadge: false,
      defaultPresentSound: false,
    );
    InitializationSettings(
        android: initializationSettingAndroid, iOS: initializationSettingIOS);
  }

  var local = tz.local;
  Future<void> showNotification(
    int id,
    String title,
    String body,
  ) async {
    await flutterLocalNotificationPlugin.zonedSchedule(
        id,
        title,
        body,
        tz.TZDateTime.now(local).add(Duration(seconds: 1)),
        const NotificationDetails(
          android: AndroidNotificationDetails('main_channel', 'Main Channel',
              priority: Priority.max,
              importance: Importance.max,
              icon: 'shopping_app'),
        ),
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true);
  }
}
/*show(
        id,
        title,
        body,
        NotificationDetails(
          android: AndroidNotificationDetails('main channel', 'main channel',
              channelDescription: 'Main channel notification', icon: ''),
          iOS: IOSNotificationDetails(
              sound: '',
              presentAlert: true,
              presentBadge: true,
              presentSound: true),
        ),
        payload: 'kjd')*/
