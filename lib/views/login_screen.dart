// import 'package:chat/controllers/home_page_controller.dart';
// import 'package:chat/routes/app_routes.dart';
// import 'package:chat/views/home_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../controllers/login_controller.dart';
// import '../models/login_model.dart';

// class LoginScreen extends StatelessWidget {
//   final LoginController loginController = Get.put(LoginController());

//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Login')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: emailController,
//               decoration: const InputDecoration(labelText: 'Email'),
//             ),
//             TextField(
//               controller: passwordController,
//               decoration: const InputDecoration(labelText: 'Password'),
//               obscureText: true,
//             ),
//             const SizedBox(height: 20),
//             Obx(
//               () =>
//                   loginController.errorMessage.value.isNotEmpty
//                       ? Text(
//                         loginController.errorMessage.value,
//                         style: const TextStyle(color: Colors.red),
//                       )
//                       : const SizedBox(),
//             ),
//             Obx(
//               () =>
//                   loginController.isLoading.value
//                       ? const CircularProgressIndicator()
//                       : ElevatedButton(
//                         onPressed: () {
//                           // ✅ Use LoginModel
//                           LoginModel user = LoginModel(
//                             email: emailController.text,
//                             password: passwordController.text,
//                           );

//                           loginController.login(user);
//                           // homePageController.getUser();
//                         },
//                         child: const Text('Login'),
//                       ),
//             ),
//             SizedBox(height: 10),
//             Row(
//               children: [
//                 Text("you dont have an account"),
//                 SizedBox(width: 10),
//                 ElevatedButton(
//                   onPressed: () {
//                     Get.offNamed(AppRoutes.signIn);
//                   },
//                   child: Text(
//                     "Register",
//                     style: TextStyle(color: Colors.green),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:chat/controllers/login_controller.dart'; // Make sure this path is correct
import 'package:chat/controllers/regi_page_controller.dart';
import 'package:chat/routes/app_routes.dart';
import 'package:chat/utils/login_input.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      init: LoginController(), // This will create and bind the controller
      builder: (controller) {
        return Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF6AC1FF), Color(0xFF3B6EFE)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            width: double.infinity,
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),
                child: Card(
                  color: Colors.white.withOpacity(0.1),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 32,
                            child: Icon(
                              Icons.chat_bubble_outline,
                              size: 32,
                              color: Colors.blue,
                            ),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Speaky',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Log in',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                          const SizedBox(height: 24),

                          _buildSocialButton(
                            'Continue with Google',
                            Icons.g_mobiledata,
                            Colors.white,
                            Colors.black,
                          ),
                          const SizedBox(height: 12),
                          _buildSocialButton(
                            'Continue with Facebook',
                            Icons.facebook,
                            Colors.white,
                            Colors.blue,
                          ),
                          const SizedBox(height: 12),
                          _buildSocialButton(
                            'Continue with Apple',
                            Icons.apple,
                            Colors.white,
                            Colors.black,
                          ),
                          const SizedBox(height: 20),

                          const Row(
                            children: [
                              Expanded(child: Divider(color: Colors.white70)),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                child: Text(
                                  'or',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              Expanded(child: Divider(color: Colors.white70)),
                            ],
                          ),

                          const SizedBox(height: 16),
                          buildTextField(
                            "Email Address",
                            controller.emailController,
                            "Enter a valid email",
                            isEmail: true,
                          ),
                          const SizedBox(height: 12),
                          Obx(
                            () => buildPasswordField1(
                              "Password",
                              controller.passController,
                              controller,
                            ),
                          ),

                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {},
                              child: const Text(
                                'Forgotten password?',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),

                          Obx(
                            () => ElevatedButton(
                              onPressed:
                                  controller.isLoading.value
                                      ? null
                                      : () => controller.loginUser(),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFB8F85B),
                                minimumSize: const Size.fromHeight(45),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child:
                                  controller.isLoading.value
                                      ? const CircularProgressIndicator(
                                        color: Colors.black,
                                      )
                                      : const Text(
                                        'Log in',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                            ),
                          ),

                          const SizedBox(height: 16),
                          RichText(
                            text: TextSpan(
                              text: 'Not yet registered? ',
                              style: const TextStyle(color: Colors.white),
                              children: [
                                TextSpan(
                                  text: 'Register',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                  ),
                                  recognizer:
                                      TapGestureRecognizer()
                                        ..onTap = () {
                                          Get.toNamed(AppRoutes.register_page);
                                        },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSocialButton(
    String text,
    IconData icon,
    Color bgColor,
    Color iconColor,
  ) {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: Icon(icon, color: iconColor),
      label: Text(text, style: TextStyle(color: iconColor)),
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor,
        minimumSize: const Size.fromHeight(45),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
