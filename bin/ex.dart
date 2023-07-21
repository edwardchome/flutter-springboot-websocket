import 'dart:convert';

import 'package:stomp_dart_client/stomp.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';

// void main() {
//   StompClient _stompClient;
//   WebSocketChannel _webSocketChannel;
//
//   _webSocketChannel = IOWebSocketChannel.connect("ws://localhost:8080/websocket");
//   _stompClient = StompClient(
//     config: StompConfig(
//       url: "ws://localhost:8080/websocket",
//       onConnect: _onConnect,
//       onWebSocketError: _onWebSocketError,
//     ),
//     webSocket: _webSocketChannel.cast<String>(),
//   );
//   _stompClient.activate();
// }








  // void _onConnect(StompClient client, StompFrame frame) {
  //   print("Connected!");
  //   _stompClient.subscribe(
  //     destination: "/topic/greetings",
  //     callback: (StompFrame frame) {
  //       setState(() {
  //         var message = json.decode(frame.body);
  //         print("Received message: ${message['content']}");
  //       });
  //     },
  //   );
  // }
  //
  // void _onWebSocketError(dynamic error) {
  //   print("WebSocket error: $error");
  // }
