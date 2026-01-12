import 'dart:io';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';

class PdfController extends GetxController {
  var isLoading = true.obs;
  var localPdfPath = "".obs;
  var errorMessage = "".obs;

  void downloadPdf(String url, String fileName) async {
    try {
      isLoading(true);
      errorMessage("");

      final dio = Dio();
      dio.options.connectTimeout = const Duration(seconds: 15);

      final dir = await getApplicationDocumentsDirectory();
      final filePath = "${dir.path}/$fileName";

      print("Attempting to download from: $url");
      print("Saving to: $filePath");

      await dio.download(url, filePath);

      localPdfPath.value = filePath;
      isLoading(false);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        errorMessage.value = "Connection timeout. Check your internet.";
      } else if (e.response?.statusCode == 404) {
        errorMessage.value = "PDF file not found on server (404).";
      } else {
        errorMessage.value = "Dio Error: ${e.message}";
      }
      print("DIO ERROR: ${e.type} -> ${e.message}");
      isLoading(false);
    } catch (e) {
      errorMessage.value = "Unexpected Error: $e";
      isLoading(false);
    }
  }
  Future<void> saveToDownloads(String fileName) async {
    try {
      if (localPdfPath.value.isEmpty) return;

      final params = SaveFileDialogParams(
        sourceFilePath: localPdfPath.value,
        fileName: fileName,
      );

      final filePath = await FlutterFileDialog.saveFile(params: params);

      if (filePath != null) {
        Get.snackbar("Success", "PDF saved successfully!",
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to save PDF",
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}