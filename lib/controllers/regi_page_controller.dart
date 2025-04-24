import 'package:chat/models/user_model.dart';
import 'package:chat/routes/app_routes.dart';
import 'package:chat/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final cnfPassController = TextEditingController();

  RxBool obscureText = true.obs;
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;

  void toggleObscureText() {
    obscureText.value = !obscureText.value;
  }

  void registerUser() async {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passController.text;
    final confirmPassword = cnfPassController.text;

    if (name.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      Get.snackbar(
        "Error",
        "Please fill all fields",
        backgroundColor: Colors.red.withOpacity(0.7),
        colorText: Colors.white,
      );
      return;
    }

    if (!email.contains('@') || !email.contains('.')) {
      Get.snackbar(
        "Error",
        "Please enter a valid email",
        backgroundColor: Colors.red.withOpacity(0.7),
        colorText: Colors.white,
      );
      return;
    }

    if (password.length < 8) {
      Get.snackbar(
        "Error",
        "Password must be at least 8 characters",
        backgroundColor: Colors.red.withOpacity(0.7),
        colorText: Colors.white,
      );
      return;
    }

    if (password != confirmPassword) {
      Get.snackbar(
        "Error",
        "Passwords do not match",
        backgroundColor: Colors.red.withOpacity(0.7),
        colorText: Colors.white,
      );
      return;
    }

    // ✅ Proceed with API call
    final user = UserModel(name: name, email: email, password: password);
    await signUp(user);
  }

  Future<void> signUp(UserModel user) async {
    print("control is here");

    isLoading(true);
    errorMessage('');

    final response = await ApiService.postRequest("register", user.toJson());

    if (response != null && !response.containsKey("error")) {
      Get.snackbar(
        "Success",
        "Registration successful!",
        backgroundColor: Colors.green.withOpacity(0.7),
        colorText: Colors.white,
      );
      Get.offNamed(AppRoutes.login);
    } else {
      errorMessage.value = response?["error"] ?? "Sign up failed!";
      Get.snackbar(
        "Error",
        errorMessage.value,
        backgroundColor: Colors.red.withOpacity(0.7),
        colorText: Colors.white,
      );
    }

    isLoading(false);
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passController.dispose();
    cnfPassController.dispose();
    super.onClose();
  }
}
