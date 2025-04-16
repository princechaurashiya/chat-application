import 'package:chat/binding/HomeBinding.dart';
import 'package:chat/binding/chatpage_binding.dart' show ChatpageBinding;
import 'package:chat/views/chat_screen.dart';
import 'package:chat/views/login_screen.dart';
import 'package:get/get.dart';

import '../views/home_screen.dart';
import '../views/sign_in_screen.dart';

class AppRoutes {
  static const String login = '/';
  static const String signIn = '/signIn';
  static const String home = '/home';
  static const String chatpage = '/chatpage';

  static List<GetPage> pages = [
    GetPage(name: login, page: () => LoginScreen()),
    GetPage(name: signIn, page: () => SignInScreen()),
    GetPage(
      name: AppRoutes.home,
      page: () => HomeScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.chatpage,
      page: () => ChatPage(), // No params here
      binding: ChatpageBinding(),
    ),
  ];
}
