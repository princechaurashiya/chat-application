// import 'package:chat/routes/app_routes.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../controllers/sign_in_controller.dart';
// import '../models/user_model.dart';

// class SignInScreen extends StatelessWidget {
//   final SignInController controller = Get.put(SignInController());

//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final TextEditingController confirmPasswordController =
//       TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Sign Up")),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: nameController,
//               decoration: InputDecoration(labelText: "Name"),
//             ),
//             TextField(
//               controller: emailController,
//               decoration: InputDecoration(labelText: "Email"),
//             ),
//             TextField(
//               controller: passwordController,
//               obscureText: true,
//               decoration: InputDecoration(labelText: "Password"),
//             ),
//             TextField(
//               controller: confirmPasswordController,
//               obscureText: true,
//               decoration: InputDecoration(labelText: "Confirm Password"),
//             ),
//             SizedBox(height: 20),
//             Obx(() {
//               return ElevatedButton(
//                 onPressed:
//                     controller.isLoading.value
//                         ? null
//                         : () {
//                           var user = UserModel(
//                             name: nameController.text,
//                             email: emailController.text,
//                             password: passwordController.text,
//                             confirmPassword: confirmPasswordController.text,
//                           );
//                           controller.signUp(user);
//                         },
//                 child:
//                     controller.isLoading.value
//                         ? CircularProgressIndicator()
//                         : Text("Sign Up"),
//               );
//             }),
//             SizedBox(height: 10),
//             Row(
//               children: [
//                 Text("Already you have an account"),
//                 SizedBox(width: 10),
//                 ElevatedButton(
//                   onPressed: () {
//                     Get.offNamed(AppRoutes.login);
//                   },
//                   child: Text("LogIn", style: TextStyle(color: Colors.green)),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:chat/routes/app_routes.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF64C7F5), Color(0xFF5B5BF7)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.chat_bubble_outline,
                  color: Colors.white,
                  size: 50,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Speaky',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Register',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 30),

                // Social Buttons
                _socialButton(
                  icon: Icons.g_mobiledata,
                  text: 'Continue with Google',
                  color: Colors.white,
                  textColor: Colors.black87,
                ),
                const SizedBox(height: 15),
                _socialButton(
                  icon: Icons.facebook,
                  text: 'Continue with Facebook',
                  color: Color(0xFF4267B2),
                ),
                const SizedBox(height: 15),
                _socialButton(
                  icon: Icons.apple,
                  text: 'Continue with Apple',
                  color: Colors.black,
                ),
                const SizedBox(height: 15),
                _socialButton(
                  icon: Icons.email,
                  text: 'Register by email',
                  color: Colors.grey.shade300,
                  textColor: Colors.black87,
                ),
                const SizedBox(height: 30),

                // Login Text
                RichText(
                  text: TextSpan(
                    text: 'Already registered? ',
                    style: const TextStyle(color: Colors.white),
                    children: [
                      TextSpan(
                        text: 'Log in',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer:
                            TapGestureRecognizer()
                              ..onTap = () {
                                Get.toNamed(AppRoutes.login);
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
    );
  }

  Widget _socialButton({
    required IconData icon,
    required String text,
    required Color color,
    Color textColor = Colors.white,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton.icon(
        icon: Icon(icon, color: textColor),
        label: Text(
          text,
          style: TextStyle(color: textColor, fontWeight: FontWeight.w500),
        ),
        onPressed: () {
          Get.toNamed(AppRoutes.register_page);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 2,
        ),
      ),
    );
  }
}
