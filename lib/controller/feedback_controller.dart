import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart'; // Add this for date formatting
import 'package:just_weding_software/services/api_service.dart';

import '../view/screens/feedback_success_screen.dart';

class FeedbackController extends GetxController {
  final ApiService _apiService = ApiService();

  var isLoading = false.obs;
  var selectedRating = 5.obs;

  // Standard Form Key for bottom-line validation
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final cityController = TextEditingController();
  final instagramController = TextEditingController();
  final dobController = TextEditingController();
  final anniversaryController = TextEditingController();
  final descriptionController = TextEditingController();

  // 1. Date Picker Logic: Format automatically to YYYY-MM-DD for API
  Future<void> selectDate(BuildContext context, TextEditingController controller) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      // API formatted date
      controller.text = DateFormat('yyyy-MM-dd').format(picked);
    }
  }

  // 2. Submit Logic
  Future<void> submitFeedback() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    try {
      isLoading(true);

      Map<String, dynamic> body = {
        "rating": selectedRating.value,
        "personName": nameController.text.trim(),
        "mobileNo": int.tryParse(mobileController.text.trim()) ?? 0,
        "cityName": cityController.text.trim(),
        "instagramId": instagramController.text.trim(),
        "dateOfBirth": dobController.text.trim(),
        "anniversaryDate": anniversaryController.text.trim(),
        "description": descriptionController.text.trim(),
        "clientId": 3,
        "eventId": 27838,
      };

      final response = await _apiService.addFeedback(body);

      if (response['success'] == true) {
        _showBottomPopup(
          message: response['msg'] ?? 'Feedback submitted successfully',
          backgroundColor: Colors.green,
          iconPath: 'assets/icon/icon.png',
        );

        _clearForm();

        // Success ke baad thoda wait karke back jayein
        Future.delayed(const Duration(milliseconds: 1500), () {
          Get.off(() => const FeedbackSuccessScreen());
        });
      } else {
        _showBottomPopup(
          message: response['msg'] ?? "Submission failed",
          backgroundColor: Colors.red,
          iconPath: 'assets/icon/icon.png',
        );
      }
    } catch (e) {
      _showBottomPopup(
        message: 'Something went wrong',
        backgroundColor: Colors.red,
        iconPath: 'assets/icon/icon.png',
      );
    } finally {
      isLoading(false);
    }
  }

  void _clearForm() {
    nameController.clear();
    mobileController.clear();
    cityController.clear();
    instagramController.clear();
    dobController.clear();
    anniversaryController.clear();
    descriptionController.clear();
    selectedRating.value = 5;
  }

  @override
  void onClose() {
    nameController.dispose();
    mobileController.dispose();
    cityController.dispose();
    instagramController.dispose();
    dobController.dispose();
    anniversaryController.dispose();
    descriptionController.dispose();
    super.onClose();
  }

  // Common UI Popup
  void _showBottomPopup({
    required String message,
    required Color backgroundColor,
    required String iconPath,
  }) {
    final overlay = Overlay.of(Get.overlayContext!);
    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: 60,
        left: MediaQuery.of(context).size.width * 0.1,
        right: MediaQuery.of(context).size.width * 0.1,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(40),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(iconPath, height: 25, width: 25,
                    errorBuilder: (context, error, stackTrace) => const Icon(Icons.info, color: Colors.white)),
                const SizedBox(width: 10),
                Flexible(
                  child: Text(
                    message,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);
    Future.delayed(const Duration(seconds: 2), () => overlayEntry.remove());
  }
}