// import 'dart:html' as html;

// import 'package:chat/models/msg_model.dart';
// import 'package:chat/services/api_service.dart';
// import 'package:chat/services/socket_services.dart';
// import 'package:get/get.dart';

// class ChatController extends GetxController {
//   // Reactive message list
//   var messages = <MessageModel>[].obs;
//   bool _isSocketListenerAttached = false;

//   // Permanent variables (nullable to avoid late error)
//   String? currentUserId;
//   String? chatRoomId;
//   String? receiverId;

//   // Socket connection
//   late SocketService socketService;

//   @override
//   void onInit() {
//     super.onInit();
//     currentUserId = html.window.localStorage['user_id']?.trim();
//     chatRoomId = html.window.localStorage['chatRoomId']?.trim();
//     receiverId = html.window.localStorage['otherUserId']?.trim();
//     if (currentUserId != null && receiverId != null) {
//       print('cone on fetchMessage');
//       fetchMessages(
//         currentUserId!,
//         receiverId!,
//       ); // ⬅️ Now using getRequest internally
//     }

//     chatFeature();
//   }

//   // Fetching stored msg
//   Future<void> fetchMessages(String from, String to) async {
//     final endpoint = 'messages/$from/$to';

//     final result = await ApiService.getRequestNoHeader(
//       endpoint,
//     ); // ⬅️ Yahan YourApiClass ka use karo (replace with actual class name)

//     if (result != null && result is List) {
//       final List<MessageModel> fetchedMessages =
//           result.map((msg) => MessageModel.fromJson(msg)).toList();
//       messages.assignAll(fetchedMessages); // ✅ Update message list
//       print("📩 Past messages loaded: $fetchedMessages");
//     } else {
//       print("❌ Failed to load messages or unexpected response format");
//     }
//   }

//   //chat feature
//   void chatFeature() {
//     print("💬 Initializing chat socket features for Home Page...");

//     if (currentUserId != null) {
//       socketService = SocketService();
//       socketService.connect(currentUserId!);

//       socketService.socket.emit('registerUser', currentUserId);
//       socketService.joinRoom(chatRoomId!); // ✅ Join the room!

//       socketService.onMessageReceived((data) {
//         print("📥 New message received: $data");
//         final newMsg = MessageModel.fromJson(data);
//         messages.add(newMsg);
//         Get.snackbar(
//           "💬 New message",
//           "${data['message']}",
//           duration: Duration(seconds: 2),
//         );
//       });

//       socketService.onTyping((data) {
//         print("⌨️ Typing event from ${data['from']}");
//       });
//     }
//   }

//   // Send a message (via socket)
//   void sendMessage(String text) {
//     print("called send msg: $text");
//     if (text.trim().isEmpty) return;

//     final message = MessageModel(
//       id: DateTime.now().millisecondsSinceEpoch.toString(),
//       from: currentUserId!,
//       to: receiverId!,
//       message: text,
//       timestamp: DateTime.now(),
//     );

//     // Send to socket
//     socketService.sendMessage(
//       roomId: chatRoomId!,
//       senderId: currentUserId!,
//       receiverId: receiverId!,
//       message: text,
//     );

//     // Show own message instantly
//     messages.add(message);
//   }

//   @override
//   void onClose() {
//     socketService.disconnect(); // Disconnect when controller is closed
//     super.onClose();
//   }
// }

import 'dart:html' as html;
import 'package:chat/models/msg_model.dart';
import 'package:chat/services/api_service.dart';
import 'package:chat/services/socket_services.dart';
import 'package:chat/controllers/home_page_controller.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  // Reactive message list
  var messages = <MessageModel>[].obs;
  bool _isSocketListenerAttached = false;

  // Current chat info
  String? currentUserId;
  String? receiverId;
  String? chatRoomId;

  // Socket connection
  late SocketService socketService;

  @override
  void onInit() {
    super.onInit();
    currentUserId = html.window.localStorage['user_id']?.trim();
    receiverId = html.window.localStorage['otherUserId']?.trim();

    socketService = SocketService();
    if (currentUserId != null) {
      socketService.connect(currentUserId!);
      socketService.socket.emit('registerUser', currentUserId);
    }

    if (currentUserId != null && receiverId != null) {
      startChatWithUser(receiverId!);
    }
  }

  /// Getter for current chat user using HomePageController
  dynamic get currentChatUser {
    if (receiverId == null) return null;
    return Get.find<HomePageController>().users.firstWhereOrNull(
      (u) => u.id == receiverId,
    );
  }

  /// Starts or switches chat with a given user ID
  void startChatWithUser(String newReceiverId) {
    receiverId = newReceiverId;
    chatRoomId = _generateRoomId(currentUserId!, receiverId!);
    html.window.localStorage['chatRoomId'] = chatRoomId!;
    html.window.localStorage['otherUserId'] = receiverId!;

    messages.clear(); // clear previous messages
    fetchMessages(currentUserId!, receiverId!);
    socketService.joinRoom(chatRoomId!);

    if (!_isSocketListenerAttached) {
      _attachSocketListeners();
    }

    update(); // Update any UI observers manually if needed
  }

  /// Generate consistent room ID based on sorted user IDs
  String _generateRoomId(String id1, String id2) {
    final sorted = [id1, id2]..sort();
    return '${sorted[0]}_${sorted[1]}';
  }

  /// Fetch stored messages from backend
  Future<void> fetchMessages(String from, String to) async {
    final endpoint = 'messages/$from/$to';

    try {
      final result = await ApiService.getRequestNoHeader(endpoint);
      if (result != null && result is List) {
        final List<MessageModel> fetchedMessages =
            result.map((msg) => MessageModel.fromJson(msg)).toList();
        messages.assignAll(fetchedMessages);
        print("📩 Past messages loaded.");
      } else {
        print("❌ Failed to load messages or unexpected response format.");
      }
    } catch (e) {
      print("❌ Error fetching messages: $e");
    }
  }

  /// Attach socket listeners for new messages and typing
  void _attachSocketListeners() {
    socketService.onMessageReceived((data) {
      final newMsg = MessageModel.fromJson(data);
      messages.add(newMsg);

      Get.snackbar(
        "💬 New message",
        "${data['message']}",
        duration: const Duration(seconds: 2),
      );
    });

    socketService.onTyping((data) {
      print("⌨️ Typing event from ${data['from']}");
      // Add typing indicator logic here
    });

    _isSocketListenerAttached = true;
  }

  /// Send a message
  void sendMessage(String text) {
    if (text.trim().isEmpty || chatRoomId == null || receiverId == null) return;

    final message = MessageModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      from: currentUserId!,
      to: receiverId!,
      message: text,
      timestamp: DateTime.now(),
    );

    // Emit via socket
    socketService.sendMessage(
      roomId: chatRoomId!,
      senderId: currentUserId!,
      receiverId: receiverId!,
      message: text,
    );

    // Add instantly to UI
    messages.add(message);
  }

  @override
  void onClose() {
    if (_isSocketListenerAttached) {
      socketService.disconnect();
    }
    super.onClose();
  }
}
