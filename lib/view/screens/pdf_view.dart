import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controller/pdf_controller.dart';

class PdfViewerScreen extends StatelessWidget {
  final String pdfUrl;
  final String title;

  PdfViewerScreen({super.key, required this.pdfUrl, required this.title});

  @override
  Widget build(BuildContext context) {
    final PdfController pdfController = Get.put(PdfController());

    pdfController.downloadPdf(pdfUrl, "exclusive_menu.pdf");

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back_ios,color: Colors.black,)),
        title: Text(title,style: GoogleFonts.nunito(fontSize: 19,color: Colors.black,fontWeight: FontWeight.w700),),
        actions: [
          IconButton(
            onPressed: () => pdfController.saveToDownloads("exclusive_menu.pdf"),
            icon: const Icon(Icons.download_rounded, color: Colors.black),
          )
        ],
      ),
      body: Obx(() {
        if (pdfController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (pdfController.errorMessage.isNotEmpty) {
          return Center(child: Text(pdfController.errorMessage.value));
        }

        return PDFView(
          filePath: pdfController.localPdfPath.value,
          swipeHorizontal: false,
          autoSpacing: true,
          pageSnap: true,
          fitEachPage: true,
        );
      }),
    );
  }
}