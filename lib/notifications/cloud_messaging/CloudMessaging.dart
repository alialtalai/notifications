import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../local_notification/LocalNotification.dart';


class CloudMessaging{

  CloudMessaging();

  CloudMessaging.initialize(){
    _setUpNotificationPermission();
    _getToken();
    _cloudMessagingHandling();
  }

  _getToken()async{
    String token= await FirebaseMessaging.instance.getToken()??'';
    debugPrint('Firebase notification token: $token');
  }

  _cloudMessagingHandling(){
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint('onMessage received');
      debugPrint(message.notification?.title);
      LocalNotification().showLocalNotification(id: message.hashCode, title: message.notification?.title, body: message.notification?.body);
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
    debugPrint('User granted permission: ${settings.authorizationStatus}');
  }

}