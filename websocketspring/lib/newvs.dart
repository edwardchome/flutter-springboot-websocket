import 'dart:async';
import 'dart:convert';

import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';


void main() {
  stompClient.activate();
}

void onConnect(StompFrame frame) {
  stompClient.subscribe(
    destination: '/topic/message',
    callback: (frame) {
      List<dynamic>? result = json.decode(frame.body!);
      print(result);
    },
  );

  Timer.periodic(Duration(seconds: 10), (_) {
    stompClient.send(
      destination: '/send',
      body: json.encode({'message': '123'}),
    );
  });
}

final stompClient = StompClient(
  config: StompConfig(
    url: 'ws://192.168.1.3:8080/ws',
    onConnect: onConnect,
    beforeConnect: () async {
      print('waiting to connect...');
      await Future.delayed(Duration(milliseconds: 200));
      print('connecting...');
    },
    onWebSocketError: (dynamic error) => print(error.toString()),
    //stompConnectHeaders: {'Authorization': 'Bearer yourToken'},
    //webSocketConnectHeaders: {'Authorization': 'Bearer yourToken'},
  ),
);
