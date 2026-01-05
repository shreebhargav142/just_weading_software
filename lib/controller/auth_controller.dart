

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/authModel.dart';
import '../services/api_service.dart';
import '../view/home_screen.dart';
import '../view/auth/login_screen.dart'; // Ensure correct path

class AuthController extends GetxController {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  var isLoading = false.obs;
  var user = Rxn<ClientUserDetails>();
  var userRole = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _checkExistingLogin(); // App start hote hi check karega
  }

  // Check if user is already logged in (Auto-Login Logic)
  void _checkExistingLogin() async {
    final prefs = await SharedPreferences.getInstance();
    bool? isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (isLoggedIn) {
      String? userData = prefs.getString('userData');
      if (userData != null) {
        final jsonResponse = json.decode(userData);
        final authData = AuthModel.fromJson(jsonResponse);
        if (authData.data != null && authData.data!.clientUserDetails!.isNotEmpty) {
          user.value = authData.data!.clientUserDetails![0];
          userRole.value = (user.value?.category ?? '').toLowerCase();
        }
      }
    }
  }

  bool get isCaptain =>
      (user.value?.category ?? userRole.value).toLowerCase() == 'captain';

  bool get isManager =>
      (user.value?.category ?? userRole.value).toLowerCase() == 'manager';

  // --- LOGIN FUNCTION ---
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
        if (authData.data != null && authData.data!.clientUserDetails!.isNotEmpty) {
          final details = authData.data!.clientUserDetails![0];

          user.value = details;
          final role = (details.category ?? 'user').toLowerCase();
          userRole.value = role;

          // Save to SharedPreferences for Auto-Login
          final prefs = await SharedPreferences.getInstance();
          await prefs.setBool('isLoggedIn', true); // Yeh flag important hai
          await prefs.setString('userRole', role);
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

  // --- LOGOUT FUNCTION ---
  Future<void> logout() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // 1. SharedPreferences se data clear karein
      await prefs.remove('isLoggedIn');
      await prefs.remove('userData');
      await prefs.remove('userRole');

      // 2. Controllers ko CLEAR karein (Isse fields blank ho jayengi)
      usernameController.clear();
      passwordController.clear();

      // 3. Rx variables ko reset karein
      user.value = null;
      userRole.value = '';

      // 4. Navigate to Login
      Get.offAll(() => const LoginScreen());

    } catch (e) {
      debugPrint("Logout Error: $e");
    }
  }}