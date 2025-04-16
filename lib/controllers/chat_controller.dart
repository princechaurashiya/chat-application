import 'dart:html' as html;

import 'package:chat/models/msg_model.dart';
import 'package:chat/services/api_service.dart';
import 'package:chat/services/socket_services.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  // Reactive message list
  var messages = <MessageModel>[].obs;
  bool _isSocketListenerAttached = false;

  // Permanent variables (nullable to avoid late error)
  String? currentUserId;
  String? chatRoomId;
  String? receiverId;

  // Socket connection
  late SocketService socketService;

  @override
  void onInit() {
    super.onInit();
    currentUserId = html.window.localStorage['user_id']?.trim();
    chatRoomId = html.window.localStorage['chatRoomId']?.trim();
    receiverId = html.window.localStorage['otherUserId']?.trim();
    if (currentUserId != null && receiverId != null) {
      print('cone on fetchMessage');
      fetchMessages(
        currentUserId!,
        receiverId!,
      ); // ⬅️ Now using getRequest internally
    }

    chatFeature();
  }

  // Fetching stored msg
  Future<void> fetchMessages(String from, String to) async {
    final endpoint = 'messages/$from/$to';

    final result = await ApiService.getRequestNoHeader(
      endpoint,
    ); // ⬅️ Yahan YourApiClass ka use karo (replace with actual class name)

    if (result != null && result is List) {
      final List<MessageModel> fetchedMessages =
          result.map((msg) => MessageModel.fromJson(msg)).toList();
      messages.assignAll(fetchedMessages); // ✅ Update message list
      print("📩 Past messages loaded: $fetchedMessages");
    } else {
      print("❌ Failed to load messages or unexpected response format");
    }
  }

  //chat feature
  void chatFeature() {
    print("💬 Initializing chat socket features for Home Page...");

    if (currentUserId != null) {
      socketService = SocketService();
      socketService.connect(currentUserId!);

      socketService.socket.emit('registerUser', currentUserId);
      socketService.joinRoom(chatRoomId!); // ✅ Join the room!

      socketService.onMessageReceived((data) {
        print("📥 New message received: $data");
        final newMsg = MessageModel.fromJson(data);
        messages.add(newMsg);
        Get.snackbar(
          "💬 New message",
          "${data['message']}",
          duration: Duration(seconds: 2),
        );
      });

      socketService.onTyping((data) {
        print("⌨️ Typing event from ${data['from']}");
      });
    }
  }

  // Send a message (via socket)
  void sendMessage(String text) {
    print("called send msg: $text");
    if (text.trim().isEmpty) return;

    final message = MessageModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      from: currentUserId!,
      to: receiverId!,
      message: text,
      timestamp: DateTime.now(),
    );

    // Send to socket
    socketService.sendMessage(
      roomId: chatRoomId!,
      senderId: currentUserId!,
      receiverId: receiverId!,
      message: text,
    );

    // Show own message instantly
    messages.add(message);
  }

  @override
  void onClose() {
    socketService.disconnect(); // Disconnect when controller is closed
    super.onClose();
  }
}
