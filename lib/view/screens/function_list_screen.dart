import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controller/function_controller.dart';
import '../../utils/date_utils.dart';

class FunctionListScreen extends StatelessWidget {
  const FunctionListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FunctionController controller = Get.find<FunctionController>();

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Get.back(),
        ),
        title: Text(
          "Function List",
          style: GoogleFonts.nunito(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.functionList.isEmpty) {
          return const Center(child: Text("No Functions Found"));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.functionList.length,
          itemBuilder: (context, index) {
            final function = controller.functionList[index];
            return _buildFunctionCard(function);
          },
        );
      }),
    );
  }

  Widget _buildFunctionCard(dynamic function) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                formatDate(function.startTime),
                style: GoogleFonts.nunito(
                  color: Colors.grey[600],
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),

              ),
              IconButton(onPressed: (){}, icon: Icon(Icons.remove_red_eye_outlined,color: Colors.black,))
            ],
          ),
          const SizedBox(height: 4),
          Text(
            function.functionName ?? "N/A",
            style: GoogleFonts.nunito(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const Divider(height: 24),
          const SizedBox(height: 8),
          _buildDetailRow("Start Time", formatDate(function.startTime) ?? "N/A"),
          const SizedBox(height: 8),
          _buildDetailRow("End Time", formatDate(function.endTime) ?? "N/A"),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.nunito(
            color: Colors.grey[700],
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.nunito(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}