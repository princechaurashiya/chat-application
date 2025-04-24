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
    var response = await ApiService.postRequest("register", user.toJson());
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
