import 'package:chat/controllers/home_page_controller.dart';
import 'package:chat/routes/app_routes.dart';
import 'package:chat/views/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/login_controller.dart';
import '../models/login_model.dart';

class LoginScreen extends StatelessWidget {
  final LoginController loginController = Get.put(LoginController());

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            Obx(
              () =>
                  loginController.errorMessage.value.isNotEmpty
                      ? Text(
                        loginController.errorMessage.value,
                        style: const TextStyle(color: Colors.red),
                      )
                      : const SizedBox(),
            ),
            Obx(
              () =>
                  loginController.isLoading.value
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                        onPressed: () {
                          // ✅ Use LoginModel
                          LoginModel user = LoginModel(
                            email: emailController.text,
                            password: passwordController.text,
                          );

                          loginController.login(user);
                          // homePageController.getUser();
                        },
                        child: const Text('Login'),
                      ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Text("you dont have an account"),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    Get.offNamed(AppRoutes.signIn);
                  },
                  child: Text(
                    "Register",
                    style: TextStyle(color: Colors.green),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
