import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/auth_controller.dart';
import '../view/home_screen.dart';
import '../view/auth/login_screen.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.put(AuthController());

    return Obx(() {
      if (authController.user.value != null &&
          authController.clientUserId.value != 0) {
        return const HomeScreen();
      } else {
        return const LoginScreen();
      }
    });
  }
}
