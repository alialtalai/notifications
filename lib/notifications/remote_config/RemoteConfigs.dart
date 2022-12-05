import 'dart:convert';

import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteConfigs{

  final remoteConfig = FirebaseRemoteConfig.instance;

  RemoteConfigs();

  RemoteConfigs.initialize(){
    _remoteConfigSetup();
    getRemoteConfig();
  }

  Future <void> _remoteConfigSetup()async{
    // should be changed before  production
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 0),
      minimumFetchInterval: const Duration(hours: 0),
    ));
  }
  
  Future <List<dynamic>> getRemoteConfig()async{
    await remoteConfig.fetchAndActivate();
    var response = remoteConfig.getString('notification_channels');
    List<dynamic> data = jsonDecode(response);

    return data;
  }



}