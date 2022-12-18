
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:huawei_push/huawei_push.dart';
import 'package:provider/provider.dart';

import '../../pages/my_home_page.dart';
import '../../providers/HuaweiNotificationProvider.dart';

class HuaweiNotifications{
  HuaweiNotifications();

  HuaweiNotifications.initialize() {
    _initTokenStream();
    _onMessageReceived();
  }

  static final homeKey= GlobalKey<MyHomePageState>();

  Future<void> _initTokenStream() async {
    Push.getToken("");
    Push.getTokenStream.listen(_onTokenEvent, onError: _onTokenError);
  }

  void _onTokenEvent(String token) {
    // Requested tokens can be obtained here
    debugPrint("TokenEvent: $token");

  }

  void _onTokenError(Object error) {
    debugPrint("TokenErrorEvent: $error");
  }

  void _onMessageReceived() {

    Push.onMessageReceivedStream.listen((RemoteMessage remoteMessage) {
      String? data = remoteMessage.data;
      debugPrint('notification remoteMessage: ${remoteMessage.notification?.body}');
      debugPrint('notification data: ${remoteMessage.dataOfMap}');

      if (data != null) {
        Push.localNotification(
          <String, String>{
            HMSLocalNotificationAttr.TITLE: 'DataMessage Received',
            HMSLocalNotificationAttr.MESSAGE: data,
          },
        );

        homeKey.currentContext?.read<HuaweiNotificationProvider>().updateLocation(double.parse(remoteMessage.dataOfMap!['latitude']!),double.parse(remoteMessage.dataOfMap!['longitude']!) );
      } else {
        debugPrint('no data message--->>!!');
      }
    });
  }
}

