import 'package:chat/controllers/chat_controller.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';

class ChatpageBinding extends Bindings {
  @override
  void dependencies() {
    print("Binding ChatController");
    Get.lazyPut(() => ChatController());
    // 👈 yaha bhi chalega
  }
}
