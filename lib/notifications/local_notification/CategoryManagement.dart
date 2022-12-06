import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:notifications/notifications/remote_config/RemoteConfigs.dart';


class CategoryManagement{

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  List<dynamic> remoteChannels=[];
  List<AndroidNotificationChannel>? channels=[];
  bool isChannelAvailable=false;

  CategoryManagement.initialize(){
    _initializeCategory();
    _filterCategories();
    _getNativeAndroidCategory();

  }



  final _remoteConfigs = RemoteConfigs();

  Future<void> _initializeCategory()async{
    remoteChannels = await _remoteConfigs.getRemoteConfig();
    debugPrint('remoteChannels: ${remoteChannels.length}');

    for(Map<String, dynamic> channel in remoteChannels){
      _addCategory(id: channel['id'], title: channel['title'], description: channel['description'], importance: channel['importance']);
    }
  }

  Future<void> _addCategory({required String id,required String title,required String description,required int importance})async{
    AndroidNotificationChannel channel;
    switch(importance){
      case 1:
        channel = AndroidNotificationChannel(id,title,description: description,importance: Importance.min);
        break;
      case 2:
        channel = AndroidNotificationChannel(id,title,description: description,importance: Importance.low);
        break;
      case 3:
        channel = AndroidNotificationChannel(id,title,description: description,importance: Importance.defaultImportance);
        break;
      case 4:
        channel = AndroidNotificationChannel(id,title,description: description,importance: Importance.high);
        break;
      default:
        channel = AndroidNotificationChannel(id,title,description: description,importance: Importance.defaultImportance);
    }
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

  }

  Future<void> _getNativeAndroidCategory()async{
    // get list of notification category from android device settings
        channels= await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.getNotificationChannels();

    for(AndroidNotificationChannel channel in channels!){
      if(channel.importance.value == 0){
        await FirebaseMessaging.instance.unsubscribeFromTopic(channel.id);
      }else{
        await FirebaseMessaging.instance.subscribeToTopic(channel.id);
      }
    }
  }

  Future<void> _filterCategories()async{
    // to remove category from android settings
    remoteChannels = await _remoteConfigs.getRemoteConfig();
    channels= await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.getNotificationChannels();

    for(AndroidNotificationChannel channel in channels!){
      isChannelAvailable= remoteChannels.map((e) => e['id']).contains(channel.id);
      if(!isChannelAvailable){
        // remove category from android setting
        await flutterLocalNotificationsPlugin
              .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
              ?.deleteNotificationChannel(channel.id);
        // unsubscribe from firebase
        await FirebaseMessaging.instance.unsubscribeFromTopic(channel.id);

        debugPrint('channel removed ${channel.id}');
      }
    }


  }





}