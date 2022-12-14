import 'package:flutter/material.dart';
import 'app.dart';
import 'flavors.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:notifications/notifications/local_notification/LocalNotification.dart';
import 'package:notifications/notifications/remote_config/RemoteConfigs.dart';

import 'notifications/cloud_messaging/CloudMessaging.dart';
import 'notifications/local_notification/CategoryManagement.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // order of initialize is important
  RemoteConfigs.initialize();
  CategoryManagement.initialize();
  CloudMessaging.initialize();
  LocalNotification.initialize();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  F.appFlavor = Flavor.FIREBASE;
  runApp(App());
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint('Handling a background message ${message.notification?.title}');
}