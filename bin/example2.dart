import 'dart:convert';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

void main(List<String> arguments) async {
  /// Create the WebSocket channel
  try {
    final channel = IOWebSocketChannel.connect(
      Uri.parse('ws://192.168.1.3:8080'),
    );

    channel.sink.add(
      jsonEncode(
        {
          "type": "/topic/public",
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
  } catch (e) {
    print(e);
  }

  /// Wait for 5 seconds
  //await Future.delayed(Duration(seconds: 5));

  /// Close the channel
  // channel.sink.close();
}
