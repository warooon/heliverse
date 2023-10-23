import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heliverse/app/controllers/user_controller.dart';
import 'package:heliverse/app/screens/user_list.dart';

void main() {
  Get.put(UserController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData.dark(),
      home: const Scaffold(
        body: UserListScreen(),
      ),
      initialBinding: BindingsBuilder(() {
        Get.lazyPut<UserController>(() => UserController());
      }),
    );
  }
}
