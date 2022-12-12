import 'package:flutter/material.dart';
import 'package:notifications/notifications/huawei_notification/InAppMessagingHuawei.dart';
import 'app.dart';
import 'flavors.dart';

import 'package:notifications/notifications/huawei_notification/HuaweiNotification.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  HuaweiNotificaions.initialize();
  InAppMessagingHuawei.initialize(pageName: 'main');
  F.appFlavor = Flavor.HUAWEI;
  runApp(App());
}
//IQAAAACy0x2EAABrsiKw7D84bSS0OE8X1QGtep625K9Nnd_F7LygSSpAVkPb-0DRzWg_MKOKjsXT-JjuVW9KyXzZ3aJ0yCUlW5sb7JL18tfEBR0Eqg