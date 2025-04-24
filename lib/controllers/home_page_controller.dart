// import 'dart:developer';
// import 'dart:html' as html;

// import 'package:chat/models/msg_model.dart';
// import 'package:chat/routes/app_routes.dart';
// import 'package:chat/services/auth.dart';
// import 'package:chat/services/socket_services.dart';
// import 'package:chat/utils/chat_utils.dart';
// import 'package:get/get.dart';

// import '../models/user_model.dart';
// import '../services/api_service.dart';

// class HomePageController extends GetxController {
//   var isLoading = false.obs;
//   var errorMsg = "".obs;
//   var users = <UserModel>[].obs;
//   var onlineUsers = <String>[].obs;

//   var messages = <MessageModel>[].obs;
//   var unreadCounts = <String, int>{}.obs;

//   late SocketService socketService;
//   String? currentUserId;

//   @override
//   void onInit() {
//     super.onInit();
//     log("🌀 HomePageController initialized");
//     loadCurrentUserId();
//     getUsers();
//   }

//   void loadCurrentUserId() {
//     currentUserId = AuthService.getUserId();
//     log("🪪 Loaded currentUserId: $currentUserId");

//     if (currentUserId != null) {
//       socketService = SocketService();
//       socketService.connect(currentUserId!);

//       socketService.onOnlineUsersUpdate((userIds) {
//         log(" home page contriller📡 Online users: $userIds");
//         onlineUsers.value = userIds;
//         sortUsers();
//       });

//       socketService.onMessageReceived((data) {
//         log("📥 Message received: $data");
//         messages.add(MessageModel.fromJson(data));

//         final fromId = data['from'];
//         if (fromId != currentUserId) {
//           unreadCounts[fromId] = (unreadCounts[fromId] ?? 0) + 1;
//           log("🔴 Updated unread count for $fromId: ${unreadCounts[fromId]}");

//           sortUsers();

//           Get.snackbar(
//             "💬 New message",
//             "${data['message']}",
//             duration: Duration(seconds: 2),
//           );
//         }
//       });

//       socketService.onTyping((data) {
//         log("⌨️ ${data['from']} is typing...");
//       });
//     }
//   }

//   // void sendMessage(String toUserId, String message) {
//   //   if (currentUserId == null || message.trim().isEmpty) return;

//   //   // log("📤 Sending message to $toUserId: $message");
//   //   // socketService.sendMessage(msg);
//   //   // messages.add(MessageModel.fromJson(msg));
//   // }

//   void clearUnread(String userId) {
//     log("✅ Cleared unread for $userId");
//     unreadCounts.remove(userId);
//   }

//   int getUnreadCount(String userId) {
//     final count = unreadCounts[userId] ?? 0;
//     log("🔍 Unread count for $userId: $count");
//     return count;
//   }

//   void sortUsers() {
//     log("📊 Sorting users by online status...");
//     users.sort((a, b) {
//       final isAOnline = onlineUsers.contains(a.id);
//       final isBOnline = onlineUsers.contains(b.id);

//       if (isAOnline && !isBOnline) return -1;
//       if (!isAOnline && isBOnline) return 1;
//       return a.name!.compareTo(b.name!);
//     });
//   }

//   Future<void> getUsers() async {
//     isLoading(true);
//     errorMsg("");
//     log("🌐 Fetching users...");

//     try {
//       String? token = html.window.localStorage['auth_key'];
//       log("🔑 Token from localStorage: $token");

//       if (token == null || token.trim().isEmpty) {
//         errorMsg.value = "No authentication token found!";
//         log("❌ Token is null or empty");
//         return;
//       }

//       var response = await ApiService.getRequest("see-user", token: token);

//       if (response == null) {
//         errorMsg.value = "No response from server!";
//         log("❌ Null response from API");
//         return;
//       }

//       log("🔹 Response Code: 200");
//       log("📦 Response: $response");

//       if (response["success"] == true && response.containsKey("data")) {
//         List<dynamic> data = response["data"];

//         if (data is List) {
//           users.value =
//               data.map((userJson) => UserModel.fromJson(userJson)).toList();
//           log("👥 Loaded ${users.length} users");

//           currentUserId = html.window.localStorage['user_id'];
//           sortUsers();
//         } else {
//           errorMsg.value = "Unexpected data format received!";
//           log("❌ Data format is not List");
//         }
//       } else {
//         errorMsg.value =
//             response["message"] ?? response["mess"] ?? "Something went wrong!";
//         log("❌ API error message: ${errorMsg.value}");
//       }
//     } catch (e) {
//       errorMsg.value = "Network error! Please try again.";
//       log("❌ Exception in getUsers(): $e");
//     } finally {
//       isLoading(false);
//     }
//   }

//   void openChatWithUser(UserModel otherUser) {
//     final currentUserId = html.window.localStorage['user_id']?.trim();

//     if (currentUserId == null || otherUser == null) return;

//     final chatRoomId = generateChatRoomId(currentUserId, otherUser.id!);
//     html.window.localStorage['chatRoomId'] = chatRoomId;

//     clearUnread(otherUser.id!);
//     html.window.localStorage['otherUserId'] = otherUser.id!;

//     Get.toNamed(
//       AppRoutes.chatpage,
//       arguments: {
//         // 'chatRoomId': chatRoomId,
//         //'currentUserId': currentUserId,
//         'otherUser': otherUser, // Make sure 'otherUser' is not null
//       },
//     );
//   }
// }

import 'dart:developer';
import 'dart:html' as html;

import 'package:chat/models/msg_model.dart';
import 'package:chat/routes/app_routes.dart';
import 'package:chat/services/auth.dart';
import 'package:chat/services/socket_services.dart';
import 'package:chat/utils/chat_utils.dart';
import 'package:get/get.dart';

import '../models/user_model.dart';
import '../services/api_service.dart';
import 'chat_controller.dart';

class HomePageController extends GetxController {
  var isLoading = false.obs;
  var errorMsg = "".obs;
  var users = <UserModel>[].obs;
  var onlineUsers = <String>[].obs;

  var messages = <MessageModel>[].obs;
  var unreadCounts = <String, int>{}.obs;

  late SocketService socketService;
  String? currentUserId;

  @override
  void onInit() {
    super.onInit();
    log("🌀 HomePageController initialized");
    loadCurrentUserId();
    getUsers();
  }

  void loadCurrentUserId() {
    currentUserId = AuthService.getUserId();
    log("🪪 Loaded currentUserId: $currentUserId");

    if (currentUserId != null) {
      socketService = SocketService();
      socketService.connect(currentUserId!);
      socketService.socket.emit("registerUser", currentUserId);

      socketService.onOnlineUsersUpdate((userIds) {
        log("📡 Online users: $userIds");
        onlineUsers.value = userIds;
        sortUsers();
      });

      socketService.onMessageReceived((data) {
        log("📥 Message received: $data");
        final msg = MessageModel.fromJson(data);
        messages.add(msg);

        final fromId = data['from'];
        if (fromId != currentUserId) {
          unreadCounts[fromId] = (unreadCounts[fromId] ?? 0) + 1;
          log("🔴 Updated unread count for $fromId: ${unreadCounts[fromId]}");

          sortUsers();

          Get.snackbar(
            "💬 New message",
            "${data['message']}",
            duration: Duration(seconds: 2),
          );
        }
      });

      socketService.onTyping((data) {
        log("⌨️ ${data['from']} is typing...");
        // Optional typing indicator logic
      });
    }
  }

  void clearUnread(String userId) {
    log("✅ Cleared unread for $userId");
    unreadCounts.remove(userId);
  }

  int getUnreadCount(String userId) {
    final count = unreadCounts[userId] ?? 0;
    log("🔍 Unread count for $userId: $count");
    return count;
  }

  void sortUsers() {
    log("📊 Sorting users by online status...");
    users.sort((a, b) {
      final isAOnline = onlineUsers.contains(a.id);
      final isBOnline = onlineUsers.contains(b.id);

      if (isAOnline && !isBOnline) return -1;
      if (!isAOnline && isBOnline) return 1;
      return a.name!.compareTo(b.name!);
    });
  }

  Future<void> getUsers() async {
    isLoading(true);
    errorMsg("");
    log("🌐 Fetching users...");

    try {
      String? token = html.window.localStorage['auth_key'];
      log("🔑 Token from localStorage: $token");

      if (token == null || token.trim().isEmpty) {
        errorMsg.value = "No authentication token found!";
        return;
      }

      var response = await ApiService.getRequest("see-user", token: token);

      if (response == null) {
        errorMsg.value = "No response from server!";
        return;
      }

      if (response["success"] == true && response.containsKey("data")) {
        List<dynamic> data = response["data"];

        if (data is List) {
          users.value =
              data.map((userJson) => UserModel.fromJson(userJson)).toList();
          currentUserId = html.window.localStorage['user_id'];
          sortUsers();
          log("👥 Loaded ${users.length} users");
        } else {
          errorMsg.value = "Unexpected data format received!";
        }
      } else {
        errorMsg.value =
            response["message"] ?? response["mess"] ?? "Something went wrong!";
      }
    } catch (e) {
      errorMsg.value = "Network error! Please try again.";
      log("❌ Exception in getUsers(): $e");
    } finally {
      isLoading(false);
    }
  }

  /// Open or switch chat with another user
  void openChatWithUser(UserModel otherUser) {
    final currentUserId = html.window.localStorage['user_id']?.trim();
    if (currentUserId == null || otherUser.id == null) return;

    final chatRoomId = generateChatRoomId(currentUserId, otherUser.id!);
    html.window.localStorage['chatRoomId'] = chatRoomId;
    html.window.localStorage['otherUserId'] = otherUser.id!;

    clearUnread(otherUser.id!);

    // Update existing ChatController if it's in memory
    if (Get.isRegistered<ChatController>()) {
      final chatController = Get.find<ChatController>();
      chatController.startChatWithUser(otherUser.id!);
    } else {
      // Navigate to chat page only if not already there
      Get.toNamed(AppRoutes.chatpage, arguments: {'otherUser': otherUser});
    }
  }
}
