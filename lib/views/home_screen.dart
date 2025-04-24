// import 'package:chat/controllers/home_page_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class HomeScreen extends StatelessWidget {
//   final HomePageController controller = Get.put(HomePageController());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('🧑‍🤝‍🧑 Users')),
//       body: Obx(() {
//         if (controller.isLoading.value) {
//           return Center(child: CircularProgressIndicator());
//         }

//         if (controller.errorMsg.isNotEmpty) {
//           return Center(child: Text(controller.errorMsg.value));
//         }

//         return ListView.builder(
//           itemCount: controller.users.length,
//           itemBuilder: (context, index) {
//             final user = controller.users[index];
//             final isOnline = controller.onlineUsers.contains(user.id);

//             final unread = controller.getUnreadCount(user.id ?? "");

//             return ListTile(
//               leading: CircleAvatar(
//                 backgroundColor: isOnline ? Colors.green : Colors.grey,
//                 child: Text(user.name?[0] ?? "?"),
//               ),
//               title: Text(user.name ?? "Unknown"),
//               subtitle: Row(
//                 children: [Text(isOnline ? "🟢 Online" : "⚫ Offline")],
//               ),
//               trailing:
//                   unread > 0
//                       ? CircleAvatar(
//                         radius: 12,
//                         backgroundColor: Colors.red,
//                         child: Text(
//                           '$unread',
//                           style: TextStyle(color: Colors.white, fontSize: 12),
//                         ),
//                       )
//                       : null,
//               onTap: () {
//                 controller.openChatWithUser(user);
//               },
//             );
//           },
//         );
//       }),
//     );
//   }
// }

import 'package:chat/views/community_page/community_page.dart';
import 'package:chat/views/msg_page/msg_page.dart';
import 'package:chat/views/profile_page/profile_page.dart';
import 'package:flutter/material.dart';

class Community extends StatefulWidget {
  const Community({super.key});

  @override
  State<Community> createState() => _CommunityState();
}

class _CommunityState extends State<Community> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    CommunityPage(),
    ChatScreen(),
    const ProfilePage(),
  ];

  final List<Map<String, dynamic>> _navItems = [
    {'icon': Icons.groups_outlined, 'label': 'Community'},
    {'icon': Icons.message_outlined, 'label': 'Messages'},
    {'icon': Icons.person_outline, 'label': 'Profile'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade200,
        elevation: 2,
        title: Row(
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [Color(0xFF4A90E2), Color(0xFF6FC0FF)],
                ),
              ),
              child: const Center(
                child: Icon(Icons.chat_bubble_outline, color: Colors.white),
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              'Speaky',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: List.generate(_navItems.length, (index) {
          final item = _navItems[index];
          final isSelected = _selectedIndex == index;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: InkWell(
              onTap: () {
                setState(() {
                  _selectedIndex = index;
                });
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    item['icon'],
                    color: isSelected ? Colors.blue : Colors.black,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item['label'],
                    style: TextStyle(
                      fontSize: 12,
                      color: isSelected ? Colors.blue : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
      body: _pages[_selectedIndex], // 👈 Actual content page load here
    );
  }
}
