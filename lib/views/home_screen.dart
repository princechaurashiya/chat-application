import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_page_controller.dart';

class HomeScreen extends StatelessWidget {
  final HomePageController controller = Get.put(HomePageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('🧑‍🤝‍🧑 Users')),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (controller.errorMsg.isNotEmpty) {
          return Center(child: Text(controller.errorMsg.value));
        }

        return ListView.builder(
          itemCount: controller.users.length,
          itemBuilder: (context, index) {
            final user = controller.users[index];
            final isOnline = controller.onlineUsers.contains(user.id);

            final unread = controller.getUnreadCount(user.id ?? "");

            return ListTile(
              leading: CircleAvatar(
                backgroundColor: isOnline ? Colors.green : Colors.grey,
                child: Text(user.name?[0] ?? "?"),
              ),
              title: Text(user.name ?? "Unknown"),
              subtitle: Row(
                children: [Text(isOnline ? "🟢 Online" : "⚫ Offline")],
              ),
              trailing:
                  unread > 0
                      ? CircleAvatar(
                        radius: 12,
                        backgroundColor: Colors.red,
                        child: Text(
                          '$unread',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      )
                      : null,
              onTap: () {
                controller.openChatWithUser(user);
              },
            );
          },
        );
      }),
    );
  }
}
