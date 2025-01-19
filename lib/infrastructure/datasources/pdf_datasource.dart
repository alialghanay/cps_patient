import 'dart:typed_data';
import 'package:cps_patient/core/di/configure_dependencies.dart';

class PdfDataSource {
  final DioProvider dioProvider;

  PdfDataSource(this.dioProvider);

  Future<Uint8List> fetchPdf(int id) async {
    try {
      final dio = dioProvider.createDio(
        baseURL: 'http://127.0.0.1:8000',
        auth: true,
        formData: false,
      );
      final response = await dio.get('/file/api/reports/$id/generate-pdf/');
      return response.data;
    } catch (e) {
      throw Exception('Failed to fetch PDF: $e');
    }
  }
}
