
import 'package:agconnect_appmessaging/agconnect_appmessaging.dart';
import 'package:flutter/material.dart';

class InAppMessagingHuawei {
  final AGCAppMessaging _appMessaging = AGCAppMessaging.getInstance();

   String pageName='';
  InAppMessagingHuawei.initialize({required this.pageName}){
    print('InAppMessagingHuawei.initialize: $pageName');
    // for testing only, after 5 attempts re-install the application and clear the cash
    _appMessaging.setForceFetch();

    messageDisplay();
    messageDismiss();
    messageClick();
    messageError();

  }

  void messageDisplay(){

  _appMessaging.onMessageDisplay.listen((AppMessage event) {

  // _showDialog(context, 'onMessageDisplay', event);
    debugPrint('onMessage Display---> : ${event} ');
    debugPrint('page name $pageName');
  });
}

 void messageDismiss(){
   _appMessaging.onMessageDismiss.listen((AppMessage event) {
     // _showDialog(context, 'onMessageDismiss', event);
     debugPrint('onMessage Dismiss---> : ${event} ');
     debugPrint('page name $pageName');


   });
 }

 void messageClick(){
   _appMessaging.onMessageClick.listen((AppMessage event) {
     // _showDialog(context, 'onMessageClick', event);
     debugPrint('onMessage Click---> : ${event} ');
     debugPrint('page name $pageName');


   });
 }

 void messageError(){
    _appMessaging.onMessageError.listen((AppMessage event) {
      debugPrint('onMessage Error---> : ${event} ');
      debugPrint('page name $pageName');

    });
 }

  void _showDialog(BuildContext context, String title, [dynamic content]) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: content == null
              ? null
              : SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Text('$content'),
          ),
        );
      },
    );
  }



}
