import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/authModel.dart';
import '../services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../view/home_screen.dart';

// class AuthController extends GetxController {
//
//   final usernameController = TextEditingController();
//   final passwordController = TextEditingController();
//
//   var isLoading = false.obs;
//
//   var user = Rxn<ClientUserDetails>();
//   var userRole=''.obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     _loadUserRole();
//   }
//
//   void _loadUserRole()async{
//     SharedPreferences prefs= await SharedPreferences.getInstance();
//     userRole.value= prefs.getString('userRole') ?? '';
//   }
//   bool get isCaptain => userRole.value == 'captain';
//   bool get isManager => userRole.value == 'Manager';
//
//
//   void login() async {
//     if (usernameController.text.isEmpty && passwordController.text.isEmpty) {
//       _showBottomPopup(
//         message: "Please enter username and password",
//         backgroundColor: Colors.red.shade700,
//         iconPath: 'assets/icon/icon.png',
//       );
//       return;
//     }
//     if(usernameController.text.isEmpty){
//       _showBottomPopup(message: 'Please Enter UserName', backgroundColor: Colors.red.shade700,
//           iconPath: 'assets/icon/icon.png');
//       return;
//     }
//     if(passwordController.text.isEmpty){
//       _showBottomPopup(message: 'Please Enter Password', backgroundColor: Colors.red.shade700,
//           iconPath: 'assets/icon/icon.png');
//       return;
//     }
//
//     try {
//       isLoading.value = true;
//
//       var response = await ApiService.getLoginCustomer(
//           usernameController.text.trim(),
//           passwordController.text.trim()
//       );
//
//       var jsonResponse = json.decode(response.body);
//       print("API RESPONSE: $jsonResponse");
//       var authData = AuthModel.fromJson(jsonResponse);
//
//       if (response.statusCode == 200 && authData.success == true) {
//
//         if (authData.data != null &&
//             authData.data!.clientUserDetails != null &&
//             authData.data!.clientUserDetails!.isNotEmpty) {
//
//           var details = authData.data!.clientUserDetails![0];
//           user.value = details;
//           String role = details.category ?? 'user';
//           userRole.value = role;
//           SharedPreferences prefs= await SharedPreferences.getInstance();
//           await prefs.setString('userData', jsonEncode(jsonResponse));
//           String dataToSave = json.encode(jsonResponse);
//           await prefs.setString('userRole', role);
//           print("DATA SAVED SUCCESSFULLY: $dataToSave");
//
//           _showBottomPopup(message:  "Welcome ${user.value!.userName}",
//               backgroundColor: Colors.green, iconPath: 'assets/icon/icon.png');
//           Get.offAll(() => HomeScreen());
//         } else {
//           _showBottomPopup(message:  "Invalid Credentials",
//               backgroundColor: Colors.red, iconPath: 'assets/icon/icon.png');
//
//         }
//       } else {
//         _showBottomPopup(message: "LogIn failed",
//             backgroundColor: Colors.red, iconPath: 'assets/icon/icon.png');
//
//       }
//
//     } catch (e) {
//       _showBottomPopup(message: 'Server Error', backgroundColor: Colors.red, iconPath: 'assets/icon/icon.png');
//       print(e);
//     } finally {
//       isLoading.value = false;
//     }
//   }
//   void _showBottomPopup({
//     required String message,
//     required Color backgroundColor,
//     required String iconPath,
//   }) {
//     OverlayEntry overlayEntry = OverlayEntry(
//       builder: (context) => Positioned(
//         bottom: 60,
//         left: MediaQuery.of(context).size.width * 0.1,
//         right: MediaQuery.of(context).size.width * 0.1,
//         child: Material(
//           color: Colors.transparent,
//           child: AnimatedOpacity(
//             duration: const Duration(milliseconds: 300),
//             opacity: 1.0,
//             child: Container(
//               padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
//               decoration: BoxDecoration(
//                 color: backgroundColor,
//                 borderRadius: BorderRadius.circular(40),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.3),
//                     blurRadius: 6,
//                     offset: const Offset(0, 3),
//                   ),
//                 ],
//               ),
//               child: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Image.asset(
//                     iconPath,
//                     height: 25,
//                     width: 25,
//                   ),
//                   const SizedBox(width: 10),
//                   Flexible(
//                     child: Text(
//                       message,
//                       textAlign: TextAlign.center,
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontSize: 15,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//
//     Overlay.of(Get.overlayContext!).insert(overlayEntry);
//     Future.delayed(const Duration(seconds: 2), () => overlayEntry.remove());
//   }
// }
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
