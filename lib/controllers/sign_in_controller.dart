import 'package:get/get.dart';

import '../models/user_model.dart';
import '../routes/app_routes.dart';
import '../services/api_service.dart';

class SignInController extends GetxController {
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  Future<void> signUp(UserModel user) async {
    isLoading(true);
    errorMessage('');

    // 🟢 Debugging: API call hone se pehle data print karo
    print("🔹 Sending API Request with Data: ${user.toJson()}");

    var response = await ApiService.postRequest("register", user.toJson());

    // 🟢 Debugging: API response print karo
    print("🔹 API Response: $response");

    if (response != null && !response.containsKey("error")) {
      print("✅ Sign Up Successful! Navigating to HomeScreen.");
      Get.offNamed(AppRoutes.home);
    } else {
      errorMessage(response?["error"] ?? "Sign up failed!");
      print("❌ Sign Up Failed! Error: ${errorMessage.value}");
    }

    isLoading(false);
  }
}
