import 'package:chat/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10),
            const NavBar(),
            Padding(
              padding: const EdgeInsets.all(40.0),
              child:
                  screenWidth < 900
                      ? const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          LeftContent(),
                          SizedBox(height: 30),
                          RightContent(),
                        ],
                      )
                      : const Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: LeftContent()),
                          SizedBox(height: 00),
                          Expanded(child: RightContent()),
                        ],
                      ),
            ),
          ],
        ),
      ),
    );
  }
}

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: const [
              Icon(Icons.chat_bubble_outline, color: Colors.blue),
              SizedBox(width: 10),
              Text(
                "speaky",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Row(
            children: [
              navItem("About Us"),
              navItem("Blog"),
              navItem("Support"),
              const SizedBox(width: 20),
              TextButton(
                onPressed: () {
                  Get.toNamed(AppRoutes.login);
                },
                child: const Text("Log in"),
              ),
              ElevatedButton(
                onPressed: () {
                  Get.toNamed(AppRoutes.signIn);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[700],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  "Signup",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget navItem(String title) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12),
    child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
  );
}

class LeftContent extends StatelessWidget {
  const LeftContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Learn languages and\nconnect with people around\nthe world",
          style: TextStyle(
            fontSize: 50,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          "Speaky is a free language exchange platform that allows you to learn\n"
          "languages from native speakers and make new friends around the world.\n"
          "Join our community and start your language learning journey today!",
          style: TextStyle(fontSize: 20, height: 1.5),
        ),
        const SizedBox(height: 100),
        ElevatedButton(
          onPressed: () {
            Get.toNamed(AppRoutes.signIn);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 25),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: const Text(
            "Join our community for free!",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ],
    );
  }
}

class RightContent extends StatelessWidget {
  const RightContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 120), // 👈 This pushes image down a bit
          Image.asset(
            "assets/images/landing.png",
            width: 650,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(Icons.person, size: 520, color: Colors.grey);
            },
          ),
        ],
      ),
    );
  }
}
