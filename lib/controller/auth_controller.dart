import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/authModel.dart';
import '../services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../view/home_screen.dart';

class AuthController extends GetxController {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  var isLoading = false.obs;

  /// Logged-in user
  var user = Rxn<ClientUserDetails>();

  /// Stored role (for app restart)
  var userRole = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _loadUserRole();
  }

  void _loadUserRole() async {
    final prefs = await SharedPreferences.getInstance();
    userRole.value = (prefs.getString('userRole') ?? '').toLowerCase();
  }

  /// ✅ SINGLE SOURCE OF TRUTH
  bool get isCaptain =>
      (user.value?.category ?? userRole.value).toLowerCase() == 'captain';

  bool get isManager =>
      (user.value?.category ?? userRole.value).toLowerCase() == 'manager';

  // ----------------------------------------------------
  // LOGIN (only role part updated)
  // ----------------------------------------------------
  void login() async {
    try {
      isLoading.value = true;

      final response = await ApiService.getLoginCustomer(
        usernameController.text.trim(),
        passwordController.text.trim(),
      );

      final jsonResponse = json.decode(response.body);
      final authData = AuthModel.fromJson(jsonResponse);

      if (response.statusCode == 200 && authData.success == true) {
        final details = authData.data!.clientUserDetails![0];

        /// Set user
        user.value = details;

        /// Normalize & store role
        final role = (details.category ?? 'user').toLowerCase();
        userRole.value = role;

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('userRole', role);
        await prefs.setString('userData', jsonEncode(jsonResponse));

        Get.offAll(() => HomeScreen());
      }
    } finally {
      isLoading.value = false;
    }
  }
}
