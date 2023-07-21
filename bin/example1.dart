import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';

void main(List<String> arguments) async {
  /// Create the WebSocket channel
  final channel = WebSocketChannel.connect(
    Uri.parse('wss://ws-feed.pro.coinbase.com'),
  );

  channel.sink.add(
    jsonEncode(
      {
        "type": "subscribe",
        "channels": [
          {
            "name": "ticker",
            "product_ids": [
              "BTC-EUR",
            ]
          }
        ]
      },
    ),
  );

  /// Listen for all incoming data
  channel.stream.listen(
        (data) {
      print(data);
    },
    onError: (error) => print(error),
  );

  /// Wait for 5 seconds
  await Future.delayed(Duration(seconds: 5));

  /// Close the channel
  channel.sink.close();

}