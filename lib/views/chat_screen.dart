import 'package:chat/controllers/chat_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ChatPage extends StatelessWidget {
  final ChatController controller = Get.find();

  final ScrollController _scrollController = ScrollController();
  final TextEditingController messageController = TextEditingController();

  ChatPage({super.key});

  void scrollToBottom() {
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

  void handleSendMessage() {
    final text = messageController.text.trim();
    if (text.isNotEmpty) {
      controller.sendMessage(text); // This should update messages list
      messageController.clear(); // Clear the input field
      scrollToBottom(); // Scroll to bottom
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Messages List
          Expanded(
            child: Obx(() {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                scrollToBottom();
              });

              return ListView.builder(
                key: ValueKey(
                  controller.messages.length,
                ), // optional force rebuild
                controller: _scrollController,
                itemCount: controller.messages.length,
                itemBuilder: (_, index) {
                  final msg = controller.messages[index];
                  final isMe = msg.from == controller.currentUserId;

                  print("Current user ID: ${controller.currentUserId}");

                  return Align(
                    alignment:
                        isMe ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                      padding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 14,
                      ),
                      decoration: BoxDecoration(
                        color: isMe ? Colors.blue[100] : Colors.grey[200],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment:
                            isMe
                                ? CrossAxisAlignment.end
                                : CrossAxisAlignment.start,
                        children: [
                          Text(msg.message, style: TextStyle(fontSize: 16)),
                          SizedBox(height: 4),
                          Text(
                            DateFormat('h:mm a').format(msg.timestamp),
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
          ),

          // Input Box
          SafeArea(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              color: Colors.grey[100],
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      onSubmitted: (_) => handleSendMessage(),
                      decoration: InputDecoration(
                        hintText: "Type a message...",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send),
                    onPressed: handleSendMessage,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
