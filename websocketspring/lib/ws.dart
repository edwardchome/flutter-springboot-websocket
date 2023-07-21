import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

// use this if you are using emulator. localhost is mapped to 10.0.2.2 by default.
//final socketUrl = 'http://192.168.1.3:8080/ws-message';
final socketUrl = 'ws://192.168.1.3:8080/ws-message';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final title = 'Websocket Demo';
    return MaterialApp(
      title: title,
      home: MyHomePage(title: title),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late StompClient stompClient;

  String message = '';

  // void onConnect(StompClient client, StompFrame frame) {
  //   client.subscribe(
  //       destination: '/topic/message',
  //       callback: (StompFrame frame) {
  //         if (frame.body != null) {
  //           Map<String, dynamic> result = json.decode(frame.body!);
  //           //print(result['message']);
  //           setState(() => message = result['message']);
  //         }
  //       });
  // }
  void onConnect2(StompFrame frame) {
    stompClient.subscribe(
      destination: '/topic/message',
      callback: (frame) {
        Map<String, dynamic> result = json.decode(frame.body!);
        print(result);
        setState(() => message = result['message']);
      },
    );
  }

  @override
  void initState() {
    super.initState();

    //if (stompClient == null) {
    //   stompClient = StompClient(
    //       config: StompConfig.SockJS(
    //         url: socketUrl,
    //         onConnect: onConnect2,
    //         onWebSocketError: (dynamic error) => print(error.toString()),
    //       ));

    stompClient = StompClient(
        config: StompConfig(
      url: socketUrl,
      onConnect: onConnect2,
      onWebSocketError: (dynamic error) => print(error.toString()),
    ));

    stompClient.activate();
    //}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Your message from server:',
            ),
            Text(
              '$message',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  @override
  void dispose() {
    stompClient.deactivate();

    super.dispose();
  }
}
