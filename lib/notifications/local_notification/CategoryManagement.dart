import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:notifications/notifications/remote_config/RemoteConfigs.dart';


class CategoryManagement{
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  final _remoteConfigs = RemoteConfigs();

  CategoryManagement.initialize(){
    _initializeCategory();
  }

  Future<void> _initializeCategory()async{
    List<dynamic> remoteChannels = await _remoteConfigs.getRemoteConfig();

    for(Map<String, dynamic> channel in remoteChannels){
      addCategory(id: channel['id'], title: channel['title'], description: channel['description'], importance: channel['importance']);
    }
  }

  Future<void> addCategory({required String id,required String title,required String description,required int importance})async{
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





}