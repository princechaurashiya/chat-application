import 'dart:html' as html;

import 'package:chat/routes/app_routes.dart';
import 'package:chat/services/socket_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  //  Get.put(SocketService()); //

  final userId =
      html.window.localStorage['user_id']; // 👈 Ya jahan se bhi userId milta ho

  if (userId != null && userId.isNotEmpty) {
    SocketService().connect(userId); // 👈 Socket connect
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      // home: Community(),
      initialRoute: AppRoutes.landing,
      // AppRoutes.login,
      getPages: AppRoutes.pages,
    );
  }
}


//mySuperprinceSecretKey123!@#