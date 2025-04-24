import 'package:chat/controllers/regi_page_controller.dart';
import 'package:chat/utils/login_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterPage extends StatelessWidget {
  final RegisterController controller = Get.put(RegisterController());
  final _formKey = GlobalKey<FormState>();

  RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF6AC1FF), Color(0xFF3B6EFE)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
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
                      const SizedBox(height: 24),
                      const Text(
                        'Are you ready to join the community?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'To be able to talk to people all around the world, you first need to create your profile.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white70),
                      ),
                      const SizedBox(height: 28),

                      buildTextField(
                        "First Name",
                        controller.nameController,
                        "Enter your name",
                      ),
                      const SizedBox(height: 12),
                      buildTextField(
                        "Email Address",
                        controller.emailController,
                        "Enter a valid email",
                        isEmail: true,
                      ),
                      const SizedBox(height: 12),
                      Obx(
                        () => buildPasswordField(
                          "Password",
                          controller.passController,
                          controller,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Obx(
                        () => buildPasswordField(
                          "Confirm Password",
                          controller.cnfPassController,
                          controller,
                          confirm: true,
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'The password must be at least 8 characters long.',
                          style: TextStyle(fontSize: 12, color: Colors.white70),
                        ),
                      ),
                      const SizedBox(height: 20),

                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Row(
                          children: const [
                            Icon(
                              Icons.check_box_outline_blank,
                              color: Colors.grey,
                            ),
                            SizedBox(width: 8),
                            Text("I'm not a robot"),
                            Spacer(),
                            FlutterLogo(size: 32),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            final name = controller.nameController.text.trim();
                            final email =
                                controller.emailController.text.trim();
                            final pass = controller.passController.text;
                            controller.registerUser();

                            Get.snackbar(
                              "Success",
                              "Name: $name\nEmail: $email\nPassword: $pass",
                              backgroundColor: Colors.green.withOpacity(0.6),
                              colorText: Colors.white,
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFB8F85B),
                          minimumSize: const Size.fromHeight(45),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Register',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Already registered? Log in',
                          style: TextStyle(color: Colors.white),
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
  }
}
