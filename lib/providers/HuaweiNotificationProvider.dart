

import 'package:flutter/cupertino.dart';

class HuaweiNotificationProvider extends ChangeNotifier{

  double latitude=0.0;
  double longitude=0.0;


  void updateLocation(latitude,longitude){
    this.latitude = latitude;
    this.longitude = longitude;
    notifyListeners();
  }
}