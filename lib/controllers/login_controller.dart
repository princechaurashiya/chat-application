// import 'package:chat/models/login_model.dart';
// import 'package:chat/routes/app_routes.dart';
// import 'package:chat/services/api_service.dart';
// import 'package:chat/services/auth.dart';
// import 'package:get/get.dart';

// class LoginController extends GetxController {
//   var isLoading = false.obs;
//   var errorMessage = "".obs;

//   /// ✅ Login Function
//   Future<void> login(LoginModel user) async {
//     isLoading.value = true;
//     errorMessage.value = "";

//     print("🔹 Sending Login Request...");

//     try {
//       final response = await ApiService.postRequest('login', user.toJson());

//       print("🔹 API Response: $response");

//       if (response == null) {
//         errorMessage.value = "No response from server!";
//         print("❌ Error: Null response from API.");
//         return;
//       }

//       if (response["success"] == true && response.containsKey("auth_key")) {
//         final String authKey = response["auth_key"] ?? "";

//         if (authKey.trim().isEmpty) {
//           errorMessage.value = "Invalid token received!";
//           print("❌ Error: Token is empty.");
//           return;
//         }

//         /// ✅ Save token and decode userId
//         AuthService.saveToken(authKey);

//         final userId = AuthService.getUserId();
//         print("✅ Logged in as User ID: $userId");

//         /// 🔁 Navigate
//         Get.offNamed(AppRoutes.home);
//       } else {
//         errorMessage.value = response["message"] ?? "Login failed!";
//         print("❌ Login Failed: ${errorMessage.value}");
//       }
//     } catch (e) {
//       errorMessage.value = "Network error! Please try again.";
//       print("❌ Exception: $e");
//     } finally {
//       isLoading.value = false;
//       print("🔄 Loading stopped.");
//     }
//   }
// }

import 'package:chat/models/user_model.dart';
import 'package:chat/routes/app_routes.dart';
import 'package:chat/services/api_service.dart';
import 'package:chat/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passController = TextEditingController();

  RxBool obscureText = true.obs;
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;

  void toggleObscureText() {
    obscureText.value = !obscureText.value;
  }

  void loginUser() async {
    final email = emailController.text.trim();
    final password = passController.text;

    if (email.isEmpty || password.isEmpty) {
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

    // ✅ Proceed with API call
    final user = UserModel(email: email, password: password);
    await login(user);
  }

  Future<void> login(UserModel user) async {
    print("⚙️ login() called");

    isLoading(true);
    errorMessage('');

    try {
      final response = await ApiService.postRequest('login', user.toJson());
      print("🔹 API Response: $response");

      if (response == null) {
        showError("No response from server!");
        return;
      }

      if (response["success"] == true && response.containsKey("auth_key")) {
        final String authKey = response["auth_key"] ?? "";

        if (authKey.trim().isEmpty) {
          showError("Invalid token received!");
          return;
        }

        // ✅ Save token, user_id and name — handled inside saveToken
        AuthService.saveToken(authKey);

        final userId = AuthService.getUserId();
        final userName = AuthService.getUserName();

        print("✅ Logged in as ID: $userId, Name: $userName");

        Get.offNamed(AppRoutes.home);
      } else {
        showError(response["message"] ?? "Login failed!");
      }
    } catch (e) {
      showError("Network error! Please try again.");
      print("❌ Exception: $e");
    } finally {
      isLoading(false);
      print("🔄 Loading stopped.");
    }
  }

  void showError(String message) {
    errorMessage(message);
    Get.snackbar(
      "Login Error",
      message,
      backgroundColor: Colors.red.withOpacity(0.7),
      colorText: Colors.white,
    );
  }

  @override
  void onClose() {
    emailController.dispose();
    passController.dispose();
    super.onClose();
  }
}
