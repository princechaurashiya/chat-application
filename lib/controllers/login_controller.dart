import 'package:chat/models/login_model.dart';
import 'package:chat/routes/app_routes.dart';
import 'package:chat/services/api_service.dart';
import 'package:chat/services/auth.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;
  var errorMessage = "".obs;

  /// ✅ Login Function
  Future<void> login(LoginModel user) async {
    isLoading.value = true;
    errorMessage.value = "";

    print("🔹 Sending Login Request...");

    try {
      final response = await ApiService.postRequest('login', user.toJson());

      print("🔹 API Response: $response");

      if (response == null) {
        errorMessage.value = "No response from server!";
        print("❌ Error: Null response from API.");
        return;
      }

      if (response["success"] == true && response.containsKey("auth_key")) {
        final String authKey = response["auth_key"] ?? "";

        if (authKey.trim().isEmpty) {
          errorMessage.value = "Invalid token received!";
          print("❌ Error: Token is empty.");
          return;
        }

        /// ✅ Save token and decode userId
        AuthService.saveToken(authKey);

        final userId = AuthService.getUserId();
        print("✅ Logged in as User ID: $userId");

        /// 🔁 Navigate
        Get.offNamed(AppRoutes.home);
      } else {
        errorMessage.value = response["message"] ?? "Login failed!";
        print("❌ Login Failed: ${errorMessage.value}");
      }
    } catch (e) {
      errorMessage.value = "Network error! Please try again.";
      print("❌ Exception: $e");
    } finally {
      isLoading.value = false;
      print("🔄 Loading stopped.");
    }
  }
}
