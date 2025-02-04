import 'package:cps_patient/services/auth_service_token.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'dart:io';
import 'package:cps_patient/services/dio_service.dart'; // ✅ Import Dio service

class PdfService {
  static Future<void> downloadReport(int fileId, BuildContext context) async {
    final String url = "/file/api/reports/$fileId/generate-pdf/";

    try {
      // Show loading indicator
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("جارٍ تحميل التقرير...")),
      );

      // Get token-based API client
      final dioService = DioService();

      // ✅ Retrieve the authentication token
      final token = await SharedPrefService().getToken();

      if (token == null) {
        throw Exception("User is not authenticated!");
      }

      // ✅ Get the temporary directory for storing the PDF
      final dir = await getApplicationDocumentsDirectory();
      final filePath = "${dir.path}/report_$fileId.pdf";

      // ✅ Make the authenticated request using DioService
      final response = await dioService.dio.get(
        url,
        options: Options(
          responseType: ResponseType.bytes, // ✅ Expecting binary data (PDF)
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': '*/*', // ✅ Accept any response format (Fixes 406 error)
          },
        ),
      );

      // ✅ Convert response to bytes
      final List<int> pdfBytes = response.data;

      // ✅ Write the file to local storage
      final File file = File(filePath);
      await file.writeAsBytes(pdfBytes, flush: true);

      // ✅ Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("تم تحميل التقرير بنجاح!")),
      );

      // ✅ Open the PDF file
      OpenFile.open(filePath);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("حدث خطأ أثناء تحميل التقرير: $e")),
      );

      print(e);
    }
  }
}
