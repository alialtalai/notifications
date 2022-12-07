import 'dart:convert';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notifications/enums/remoteConfigs.dart';

class RemoteConfigs{

  final remoteConfig = FirebaseRemoteConfig.instance;

  RemoteConfigs();

  RemoteConfigs.initialize(){
    _remoteConfigSetup();
    getRemoteConfig();
  }

  Future <void> _remoteConfigSetup()async{
    try{
      // should be changed before  production
      await remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(minutes: 0),
        minimumFetchInterval: const Duration(hours: 0),
      ));
      await remoteConfig.fetchAndActivate();

    }on PlatformException catch (exception) {
      debugPrint(exception.toString());

    } catch (exception) {
      debugPrint('Unable to fetch remote config. Cached or default values will be used');
      debugPrint(exception.toString());
    }
  }

  Future <List<dynamic>> getRemoteConfig()async{
    var response = remoteConfig.getString(remoteConfigsParameter.notification_channels.name);
    List<dynamic> data = jsonDecode(response);

    return data;
  }



}