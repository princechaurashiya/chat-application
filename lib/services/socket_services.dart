import 'dart:developer';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  // Singleton instance
  static final SocketService _instance = SocketService._internal();
  factory SocketService() => _instance;
  SocketService._internal() {
    log("🛠️ SocketService singleton created");
  }

  late IO.Socket _socket;
  late String _userId;
  bool _isConnected = false;

  // Getter function for socket
  IO.Socket get socket => _socket;

  // ✅ Connect socket and register user with reconnect logic
  void connect(String userId) {
    if (_isConnected) {
      log("⚠️ Socket already connected, skipping...");
      return;
    }

    _userId = userId;

    _socket = IO.io(
      'https://chatapp-backend-e1px.onrender.com',
      <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': false,
        'reconnect': true, // Enable reconnect
        'reconnectAttempts': 5, // Retry 5 times before giving up
        'reconnectDelay': 2000, // Retry every 2 seconds
      },
    );

    _socket.connect();

    _socket.onConnect((_) {
      _isConnected = true;
      log("✅ Socket connected as $_userId");

      if (_userId.isNotEmpty) {
        _socket.emit('registerUser', _userId);
        log("📤 Emitted registerUser: $_userId");
      } else {
        log("❌ userId is empty, registerUser not sent");
      }
    });

    _socket.onDisconnect((_) {
      _isConnected = false;
      log("❌ Socket disconnected");
    });

    _socket.onError((data) {
      log("⚠️ Socket error: $data");
    });

    _socket.onReconnect((_) {
      log("🔄 Reconnected to the socket server.");
    });

    _socket.onReconnectFailed((_) {
      log("❌ Reconnection failed after multiple attempts.");
    });

    _socket.onReconnectAttempt((attempt) {
      log("🔄 Reconnection attempt #$attempt");
    });
  }

  // ✅ Disconnect cleanly
  void disconnect() {
    if (_isConnected) {
      _socket.disconnect();
      log("🛑 Socket manually disconnected");
    } else {
      log("❌ Socket was not connected");
    }
  }

  // ✅ Send typing event
  void sendTyping({required String roomId, required String senderId}) {
    if (_isConnected) {
      final typingData = {'roomId': roomId, 'senderId': senderId};
      _socket.emit('typing', typingData);
      log("✍️ Typing event sent: $typingData");
    } else {
      log("❌ Cannot send typing, socket not connected");
    }
  }

  // ✅ Listen to typing events
  void onTyping(Function(Map<String, dynamic>) callback) {
    _socket.on('typing', (data) {
      log("✍️ Typing received: $data");
      callback(data as Map<String, dynamic>);
    });
  }

  // ✅ Join a room (needed before chatting)
  void joinRoom(String roomId) {
    if (_isConnected) {
      _socket.emit('joinRoom', roomId);
      log("🏠 Joined room: $roomId");
    } else {
      log("❌ Cannot join room, socket not connected");
    }
  }

  // ✅ Send message inside a room
  void sendMessage({
    required String roomId,
    required String senderId,
    required String receiverId,
    required String message,
  }) {
    if (_isConnected) {
      final messageData = {
        'roomId': roomId,
        'senderId': senderId,
        'text': message,
        'timestamp': DateTime.now().toIso8601String(),
      };

      // Send message to the server
      _socket.emit('send_message', {
        'from': senderId,
        'to': receiverId,
        'roomId': roomId,
        'message': message,
      });

      log("📤 Sent message to $roomId: $message");

      // Optionally, handle confirmation if message was successfully sent
      _socket.on('send_message', (response) {
        log("✅ Message sent confirmation received: $response");
      });
    } else {
      log("❌ Cannot send message, socket not connected");
    }
  }

  // ✅ Listen to messages from server
  void onMessageReceived(void Function(Map<String, dynamic>) callback) {
    print("socket onMsgReceive trigger");
    _socket.on('receive_message', (data) {
      print("socket onMsgReceive trigger2");
      log("📥 Message received: $data");

      // Ensure the message is in the correct format
      if (data is Map<String, dynamic>) {
        callback(data);
      } else {
        log("⚠️ Received data is not a valid message format: $data");
      }
    });
  }

  // ✅ Listen to online user updates
  void onOnlineUsersUpdate(Function(List<String>) callback) {
    _socket.on('updateOnlineUsers', (data) {
      try {
        log("📡 Online users update: $data");

        final users = (data as List).map((e) => e.toString()).toList();

        callback(users);
      } catch (e) {
        log("⚠️ Error parsing online users: $e");
      }
    });
  }

  // ✅ Optional: Listen to custom events
  void on(String eventName, Function(dynamic) callback) {
    _socket.on(eventName, callback);
  }
}
