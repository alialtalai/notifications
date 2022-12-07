import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotification{
  LocalNotification();

  LocalNotification.initialize(){
    _localNotificationSetUp();
    _localNotificationDevicesSetup();
  }

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  _localNotificationSetUp(){
    // display a prompt to grant an app permission for android 13 and above
    // compile SDK version needs to be at least 33
    flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()?.requestPermission();
  }

  _localNotificationDevicesSetup() async {
    // for Android
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('ic_launcher');
    // for iOS
    const DarwinInitializationSettings initializationSettingsDarwin =
     DarwinInitializationSettings(
        requestSoundPermission: true,
        requestBadgePermission: true,
        requestAlertPermission: true);
   // initialize setting
    const InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsDarwin,);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }
  /// uncomment if you want to customize notification for each platform
  Future<NotificationDetails> _notificationDetails() async {
    AndroidNotificationDetails androidPlatformChannelSpecifics =
     const AndroidNotificationDetails(
       'Application notifications',
      'Application notifications',
      importance: Importance.max,
      priority: Priority.max,
      playSound: true,
    );

    DarwinNotificationDetails iosNotificationDetails = const DarwinNotificationDetails(presentAlert: true, presentBadge: true, presentSound: true,);

    NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iosNotificationDetails);

    return platformChannelSpecifics;
  }

  Future<void> showLocalNotification({required int id, required String? title, required String? body}) async {
    final platformChannelSpecifics = await _notificationDetails();
    await flutterLocalNotificationsPlugin.show(id, title, body,platformChannelSpecifics).onError((error, stackTrace){

      print('local notification error $error');
    });
  }

}