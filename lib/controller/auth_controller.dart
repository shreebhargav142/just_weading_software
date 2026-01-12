import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/authModel.dart';
import '../services/api_service.dart';
import '../view/home_screen.dart';
import '../view/auth/login_screen.dart';

class AuthController extends GetxController {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  var isLoading = false.obs;
  var user = Rxn<ClientUserDetails>();
  var userRole = ''.obs;
  final clientUserId = 0.obs;


  @override
  void onInit() {
    super.onInit();
    _loadSessionData();
  }

  Future<void> _loadSessionData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

      if (isLoggedIn) {
        clientUserId.value = prefs.getInt('clientUserId') ?? 0;

        String? userData = prefs.getString('userData');
        if (userData != null) {
          final jsonResponse = json.decode(userData);
          final authData = AuthModel.fromJson(jsonResponse);
          if (authData.data?.clientUserDetails?.isNotEmpty ?? false) {
            user.value = authData.data!.clientUserDetails![0];
            userRole.value = (user.value?.category ?? '').toLowerCase();
          }
        }
      }
    } catch (e) {
      debugPrint("Session Load Error: $e");
    }
  }

  bool get isCaptain => (user.value?.category ?? userRole.value).toLowerCase() == 'captain';
  bool get isManager => (user.value?.category ?? userRole.value).toLowerCase() == 'manager';

  Future<bool> login() async {
    try {
      isLoading.value = true;

      final response = await ApiService.getLoginCustomer(
        usernameController.text.trim(),
        passwordController.text.trim(),
      );

      if (response.body.isEmpty) return false;

      final jsonResponse = json.decode(response.body);
      final authData = AuthModel.fromJson(jsonResponse);

      if (response.statusCode == 200 && authData.success == true) {
        if (authData.data?.clientUserDetails?.isNotEmpty ?? false) {
          final details = authData.data!.clientUserDetails![0];

          user.value = details;
          userRole.value = (details.category ?? 'user').toLowerCase();
          clientUserId.value = details.clientUserId ?? 0; // Reactive value update

          // Save to SharedPreferences
          final prefs = await SharedPreferences.getInstance();
          await prefs.setBool('isLoggedIn', true);
          await prefs.setInt('clientUserId', clientUserId.value); // Yeh line zaroori hai
          await prefs.setString('userRole', userRole.value);
          await prefs.setString('userData', jsonEncode(jsonResponse));

          Get.offAll(() => const HomeScreen());
          return true;
        }
      }
      return false;
    } catch (e) {
      debugPrint("Login Error: $e");
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();

      usernameController.clear();
      passwordController.clear();

      user.value = null;
      userRole.value = '';
      clientUserId.value = 0;

      Get.offAll(() => const LoginScreen());
    } catch (e) {
      debugPrint("Logout Error: $e");
    }
  }
}