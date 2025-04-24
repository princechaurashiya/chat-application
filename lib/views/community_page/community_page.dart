//

import 'package:chat/controllers/home_page_controller.dart';
import 'package:chat/utils/user_card.dart'; // Assume your ProfileCard is imported here
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommunityPage extends StatelessWidget {
  CommunityPage({super.key});
  final HomePageController controller = Get.put(HomePageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.errorMsg.isNotEmpty) {
          return Center(child: Text(controller.errorMsg.value));
        }

        // ✅ FIX: Make sure LayoutBuilder is returned
        return LayoutBuilder(
          builder: (context, constraints) {
            int crossAxisCount = 1;
            double width = constraints.maxWidth;

            if (width >= 1000) {
              crossAxisCount = 3; // Desktop
            } else if (width >= 770) {
              crossAxisCount = 2; // Tablet
            }

            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  mainAxisSpacing: 20,
                  mainAxisExtent: 180,
                  crossAxisSpacing: 20,
                  childAspectRatio: 350 / 180,
                ),
                itemCount: controller.users.length,
                itemBuilder: (context, index) {
                  final user = controller.users[index];
                  final isOnline1 = controller.onlineUsers.contains(user.id);
                  final unread = controller.getUnreadCount(user.id ?? "");

                  return SizedBox(
                    height: 180,
                    child: ProfileCard(
                      name: user.name ?? 'Unknown',
                      isOnline: isOnline1,
                    ),
                  );
                },
              ),
            );
          },
        );
      }),
    );
  }
}
