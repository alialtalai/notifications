import 'package:firebase_messaging/firebase_messaging.dart';


class cloudMessaging{

  cloudMessaging.initialize(){
    _cloudMessagingHandling();
    _setUpNotificationPermission();
  }

  _cloudMessagingHandling(){
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {

      print('Message received');
      print(message.notification?.title);
    });
  }

  _setUpNotificationPermission() async {

    NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    print('User granted permission: ${settings.authorizationStatus}');
  }

}