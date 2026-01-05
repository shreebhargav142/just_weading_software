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
  var user = Rxn<ClientUserDetails>();
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

  bool get isCaptain =>
      (user.value?.category ?? userRole.value).toLowerCase() == 'captain';

  bool get isManager =>
      (user.value?.category ?? userRole.value).toLowerCase() == 'manager';


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

          final prefs = await SharedPreferences.getInstance();
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
}
