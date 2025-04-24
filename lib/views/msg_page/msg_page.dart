import 'package:chat/controllers/chat_controller.dart';
import 'package:chat/controllers/home_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});

  final HomePageController controller = Get.put(HomePageController());
  final ChatController chatController = Get.find();

  final ScrollController _scrollController = ScrollController();
  final TextEditingController messageController = TextEditingController();

  void handleSendMessage() {
    final text = messageController.text.trim();
    if (text.isNotEmpty) {
      chatController.sendMessage(text);
      messageController.clear();
      Future.delayed(Duration(milliseconds: 100), () {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (controller.errorMsg.isNotEmpty) {
          return Center(child: Text(controller.errorMsg.value));
        }

        return Row(
          children: [
            // Sidebar: User List
            Container(
              width: 300,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Conversations',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Divider(),
                  Expanded(
                    child: ListView.builder(
                      itemCount: controller.users.length,
                      itemBuilder: (context, index) {
                        final user = controller.users[index];
                        final isOnline = controller.onlineUsers.contains(
                          user.id,
                        );
                        final unread = controller.getUnreadCount(user.id ?? "");

                        return ListTile(
                          leading: Stack(
                            children: [
                              CircleAvatar(
                                radius: 24,
                                backgroundColor: Colors.blue[100],
                                child: Text(user.name?[0] ?? '?'),
                              ),
                              if (isOnline)
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                    width: 10,
                                    height: 10,
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 1.5,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          title: Text(user.name ?? 'Unknown'),
                          subtitle: Text(isOnline ? " Online" : " Offline"),
                          trailing:
                              unread > 0
                                  ? CircleAvatar(
                                    radius: 10,
                                    backgroundColor: Colors.red,
                                    child: Text(
                                      '$unread',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                      ),
                                    ),
                                  )
                                  : null,
                          selected:
                              chatController.currentChatUser?.id == user.id,
                          selectedTileColor: Colors.grey.shade200,
                          onTap: () {
                            controller.openChatWithUser(user);
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            // Chat Section
            Expanded(
              child: Column(
                children: [
                  // Chat Header
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    height: 65,
                    color: Colors.white,
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        const CircleAvatar(
                          backgroundImage: NetworkImage(
                            'https://via.placeholder.com/150',
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          chatController.currentChatUser?.name ??
                              'Select a user',
                          style: TextStyle(fontSize: 16),
                        ),
                        const Spacer(),
                        IconButton(
                          icon: const Icon(Icons.more_vert),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 1),

                  // Messages Area
                  Expanded(
                    child: Obx(() {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        if (_scrollController.hasClients) {
                          _scrollController.jumpTo(
                            _scrollController.position.maxScrollExtent,
                          );
                        }
                      });

                      return ListView.builder(
                        controller: _scrollController,
                        itemCount: chatController.messages.length,
                        padding: const EdgeInsets.all(16),
                        itemBuilder: (_, index) {
                          final msg = chatController.messages[index];
                          final isMe = msg.from == chatController.currentUserId;

                          return Align(
                            alignment:
                                isMe
                                    ? Alignment.centerRight
                                    : Alignment.centerLeft,
                            child: Bubble(
                              message: msg.message,
                              timestamp: DateFormat(
                                'hh:mm a',
                              ).format(msg.timestamp),
                              isMe: isMe,
                            ),
                          );
                        },
                      );
                    }),
                  ),

                  // Input Area
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    height: 60,
                    color: Colors.white,
                    child: Row(
                      children: [
                        const Icon(Icons.emoji_emotions_outlined),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            controller: messageController,
                            onSubmitted: (_) => handleSendMessage(),
                            decoration: const InputDecoration(
                              hintText: 'Write a message',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.send, color: Colors.blue),
                          onPressed: handleSendMessage,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}

class Bubble extends StatelessWidget {
  final String message;
  final String timestamp;
  final bool isMe;

  const Bubble({
    super.key,
    required this.message,
    required this.timestamp,
    required this.isMe,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 4),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isMe ? Colors.blue : Colors.grey.shade300,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            message,
            style: TextStyle(color: isMe ? Colors.white : Colors.black),
          ),
        ),
        Text(
          timestamp,
          style: const TextStyle(fontSize: 10, color: Colors.grey),
        ),
      ],
    );
  }
}
