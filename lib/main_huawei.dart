import 'package:flutter/material.dart';
import 'app.dart';
import 'flavors.dart';


import 'package:notifications/notifications/huawei_notification/HuaweiNotification.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();

  HuaweiNotificaions.initialize();
  F.appFlavor = Flavor.HUAWEI;
  runApp(App());
}
