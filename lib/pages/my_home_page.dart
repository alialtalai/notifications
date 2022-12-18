import 'package:flutter/material.dart';
import 'package:huawei_push/huawei_push.dart';
import 'package:notifications/providers/HuaweiNotificationProvider.dart';
import 'package:provider/provider.dart';
import '../flavors.dart';




class MyHomePage extends StatefulWidget {

   const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {

  var textController = TextEditingController();





  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(F.title),),
      body: Column(
        children: [
          Center(
            child: TextField(
              controller: textController,
            ),
          ),
          ElevatedButton(
              onPressed: () {
                Push.getToken("");
                Push.getTokenStream.listen((token) {
                  setState(() {
                    textController.text = token;
                  });
                }, onError: (er) {
                  textController.text  = er.toString();
                });
              },
              child: const Text('get Token')),
          const SizedBox(height: 200,),

          Column(
            children: [
              Text('latitude: ${context.watch<HuaweiNotificationProvider>().latitude} '),
              Text('longitude: ${context.watch<HuaweiNotificationProvider>().longitude} '),
            ],
          )

        ],
      ),
    );
  }
}

