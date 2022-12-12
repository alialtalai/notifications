import 'package:flutter/material.dart';
import 'package:huawei_push/huawei_push.dart';
import '../flavors.dart';
import '../notifications/huawei_notification/InAppMessagingHuawei.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String token = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(F.title),
      ),
      body: Column(
        children: [
          Center(
            child: Text(
              '$token',
            ),
          ),
          ElevatedButton(
              onPressed: () {
                Push.getToken("");
                Push.getTokenStream.listen((token) {
                  setState(() {
                    this.token = token;
                  });
                }, onError: (er) {
                  this.token = er.toString();
                });
              },
              child: const Text('get Token'))
        ],
      ),
    );
  }
}
