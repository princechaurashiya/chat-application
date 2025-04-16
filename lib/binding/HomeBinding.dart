import 'package:chat/controllers/home_page_controller.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    // Force new instance of HomePageController for every tab
    Get.put(HomePageController(), tag: DateTime.now().toString());
    Get.lazyPut<HomePageController>(() => HomePageController());
  }
}

 //Get.put(ChatController()); // 👈 yaha bhi chalega