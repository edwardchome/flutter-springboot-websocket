import 'dart:async';
import 'dart:convert';

import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

void main() {
  try {
    stompClient.activate();
  }
  catch (e) {
    print(e);
  }
}

final stompClient = StompClient(

  config: StompConfig.SockJS(
    url: 'http://192.168.1.3:8080/ws',
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


void onConnect(StompFrame frame) {
  stompClient.subscribe(
    destination: '/topic/public',
    callback: (frame) {
      dynamic? result = json.decode(frame.body!);
      print(result);
    },
  );

  // stompClient.send("/app/chat.addUser",
  //     {},
  //     JSON.stringify({sender: username, type: 'JOIN'})
  // );

  stompClient.send(
    destination: "/app/chat.addUser",
    body: jsonEncode({"sender": "From Flutter", "type": "JOIN"}),
  );

  Timer.periodic(Duration(seconds: 10), (_) {
      stompClient.send(
        destination: '/app/chat.sendMessage',
        body: json.encode({"type": "CHAT", "content": "hie", "sender": "From Flutter"}),
      );
    });
}



// void sendMessage(event) {
//   var messageContent = messageInput.value.trim();
//   if(messageContent && stompClient) {
//     var chatMessage = {
//       sender: username,
//       content: messageInput.value,
//       type: 'CHAT'
//     };
//     stompClient.send("/app/chat.sendMessage", {}, JSON.stringify(chatMessage));
//     messageInput.value = '';
//   }
//   event.preventDefault();
// }
