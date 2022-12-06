import 'package:flutter/material.dart';
import 'package:notifications/notifications/huawei_notification/HuaweiNotification.dart';

import 'app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  HuaweiNotificaions.initialize();
  runApp( MyApp(flavor: 'Huawei',));
}