import 'package:web_socket_channel/web_socket_channel.dart';

class NotificationsSocketService {
  final String url;
  late WebSocketChannel _channel;

  NotificationsSocketService({required this.url});

  Future<void> connect() async {
    _channel = WebSocketChannel.connect(Uri.parse(url));
  }

  void sendMessage(String message) {
    if (_channel == null) {
      throw Exception("WebSocket not connected yet.");
    }
    _channel.sink.add(message);
  }

  Stream<dynamic> get notificationsStream {
    // if (_channel == null) {
    //   throw Exception("WebSocket not connected yet.");
    // }
    return _channel.stream;
  }

  void disconnect() {
    if (_channel == null) {
      throw Exception("WebSocket not connected yet.");
    }
    _channel.sink.close();
  }
}