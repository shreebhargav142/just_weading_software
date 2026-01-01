import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/feedback_controller.dart';
import 'package:just_weding_software/widgets/feedback_textfield.dart';

class FeedbackScreen extends GetView<FeedbackController> {
  const FeedbackScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final bool isTablet = MediaQuery.of(context).size.width >= 600;

    final double padding = isTablet ? 40 : 20;
    final double titleSize = isTablet ? 28 : 24;
    final double textSize = isTablet ? 16 : 14;
    final double fieldGap = isTablet ? 20 : 14;
    final double maxWidth = isTablet ? 700 : double.infinity;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: SafeArea(
        child: Form(
          key: controller.formKey,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(padding),
            child: Center(
              child: SizedBox(
                width: maxWidth,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(titleSize, textSize),
                    const SizedBox(height: 30),

                    _buildRatingSection(),
                    const SizedBox(height: 30),

                    FeedbackTextfield(
                      label: "What's your name?",
                      hint: "Full name",
                      controller: controller.nameController,
                      validator: (v) =>
                      v == null || v.isEmpty ? "Please Enter Name" : null,
                    ),
                    SizedBox(height: fieldGap),

                    FeedbackTextfield(
                      label: "Your mobile number?",
                      hint: "Mobile number",
                      controller: controller.mobileController,
                      isNumber: true,
                      validator: (v) {
                        if (v == null || v.isEmpty) {
                          return "Please Enter Mobile Number";
                        }
                        if (v.length != 10) {
                          return "Please Enter a Valid Mobile Number";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: fieldGap),

                    FeedbackTextfield(
                      label: "What's your city?",
                      hint: "City name",
                      controller: controller.cityController,
                      validator: (v) =>
                      v == null || v.isEmpty ? "Please Enter City" : null,
                    ),
                    SizedBox(height: fieldGap),

                    FeedbackTextfield(
                      label: "What's your Instagram ID",
                      hint: "Instagram ID",
                      controller: controller.instagramController,
                    ),
                    SizedBox(height: fieldGap),

                    _buildDateField(
                      context,
                      "What's your DOB",
                      controller.dobController,
                    ),
                    SizedBox(height: fieldGap),

                    _buildDateField(
                      context,
                      "What's your Anniversary",
                      controller.anniversaryController,
                    ),
                    SizedBox(height: fieldGap),

                    FeedbackTextfield(
                      label: "Any feedback, comments, or concerns?",
                      hint: "Describe your experience here...",
                      controller: controller.descriptionController,
                      maxLines: 4,
                      validator: (v) => v == null || v.isEmpty
                          ? "Please Enter Your Precious FeedBack"
                          : null,
                    ),

                    const SizedBox(height: 30),
                    _buildSubmitButton(isTablet),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ---------------- UI PARTS ----------------

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new,
            size: 18, color: Colors.black),
        onPressed: () => Get.back(),
      ),
      title: const Text(
        "Feedback",
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildHeader(double titleSize, double textSize) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Rate your experience",
          style: TextStyle(
            fontSize: titleSize,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "We highly value your feedback! Kindly take a moment to rate your experience.",
          style: TextStyle(
            fontSize: textSize,
            color: Colors.grey[600],
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildDateField(
      BuildContext context, String label, TextEditingController controller) {
    return GestureDetector(
      onTap: () => this.controller.selectDate(context, controller),
      child: AbsorbPointer(
        child: FeedbackTextfield(
          label: label,
          hint: "YYYY-MM-DD",
          controller: controller,
        ),
      ),
    );
  }

  Widget _buildRatingSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Rate our service from 1 to 5?",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 15),
        Obx(
              () => Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(5, (index) {
              final rating = index + 1;
              final selected =
                  controller.selectedRating.value == rating;

              return GestureDetector(
                onTap: () =>
                controller.selectedRating.value = rating,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    color: selected
                        ? const Color(0xFF00C853)
                        : Colors.grey[200],
                    shape: BoxShape.circle,
                    boxShadow: selected
                        ? [
                      BoxShadow(
                        color: Colors.green.withOpacity(0.3),
                        blurRadius: 8,
                      )
                    ]
                        : [],
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "$rating",
                    style: TextStyle(
                      color: selected
                          ? Colors.white
                          : Colors.grey[600],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget _buildSubmitButton(bool isTablet) {
    return Obx(
          () => SizedBox(
        width: isTablet ? 300 : double.infinity,
        height: 55,
        child: ElevatedButton(
          onPressed: controller.isLoading.value
              ? null
              : controller.submitFeedback,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFD32F2F),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 0,
          ),
          child: controller.isLoading.value
              ? const SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 2,
            ),
          )
              : const Text(
            "Send Feedback",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
