import 'package:flutter/material.dart';
import 'package:huawei_push/huawei_push.dart';

class HuaweiNotificaions{

  HuaweiNotificaions();
  // call initialize constructor into the main function in main.dart
  HuaweiNotificaions.initialize()  {
    _initTokenStream();
    _onMessageReceived();
  }


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
      if (data != null) {
        Push.localNotification(
          <String, String>{
            HMSLocalNotificationAttr.TITLE: 'DataMessage Received',
            HMSLocalNotificationAttr.MESSAGE: data,
          },
        );
      } else {
        debugPrint('no data message--->>!!');
      }
    });
  }
}