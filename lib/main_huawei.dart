import 'package:flutter/material.dart';
import 'package:notifications/notifications/huawei_notification/InAppMessagingHuawei.dart';
import 'package:notifications/providers/HuaweiNotificationProvider.dart';
import 'package:provider/provider.dart';
import 'app.dart';
import 'flavors.dart';

import 'package:notifications/notifications/huawei_notification/HuaweiNotification.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  HuaweiNotifications.initialize();
  // InAppMessagingHuawei.initialize(pageName: 'main');
  F.appFlavor = Flavor.HUAWEI;
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<HuaweiNotificationProvider>(create: (_) => HuaweiNotificationProvider()),

    ],
    child: App(),
  ));
}
