import 'package:chat/binding/HomeBinding.dart';
import 'package:chat/binding/chatpage_binding.dart' show ChatpageBinding;
import 'package:chat/views/chat_screen.dart';
import 'package:chat/views/home_screen.dart';
import 'package:chat/views/landing_screen.dart';
import 'package:chat/views/login_screen.dart';
import 'package:chat/views/register_page.dart';
import 'package:chat/views/sign_in_screen.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class AppRoutes {
  static const String landing = '/';
  static const String register_page = '/register_page';

  static const String login = '/login';
  static const String signIn = '/signIn';
  static const String home = '/home';
  static const String chatpage = '/chatpage';

  static List<GetPage> pages = [
    GetPage(name: landing, page: () => LandingPage()),
    GetPage(name: register_page, page: () => RegisterPage()),
    GetPage(name: login, page: () => LoginPage()),
    GetPage(name: signIn, page: () => SignInPage()),
    GetPage(
      name: AppRoutes.home,
      page: () => Community(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.chatpage,
      page: () => ChatPage(), // No params here
      binding: ChatpageBinding(),
    ),
  ];
}
