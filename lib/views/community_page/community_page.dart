import 'package:chat/utils/user_card.dart'; // Assume your ProfileCard is imported here
import 'package:flutter/material.dart';

class CommunityPage extends StatelessWidget {
  const CommunityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Check width and decide column count
          int crossAxisCount = 1;
          double width = constraints.maxWidth;

          if (width >= 1000) {
            crossAxisCount = 3; // Desktop
          } else if (width >= 770) {
            crossAxisCount = 2; // Tablet
          } else {
            crossAxisCount = 1; // Mobile
          }

          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                mainAxisSpacing: 20,
                mainAxisExtent: 180,
                crossAxisSpacing: 20,
                childAspectRatio: 350 / 180, // width/height ratio
              ),
              itemCount: 12,
              itemBuilder: (context, index) {
                return SizedBox(
                  height: 180,
                  child: ProfileCard(name: 'prince'),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
