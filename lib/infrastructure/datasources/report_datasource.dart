import 'package:cps_patient/core/di/configure_dependencies.dart';
import 'package:dio/dio.dart';

class ReportDataSource {
  final DioProvider dioProvider;

  ReportDataSource(this.dioProvider);

  Future<Map<String, dynamic>> fetchReport() async {
    final dio = dioProvider.createDio(
      baseURL: 'http://127.0.0.1:8000',
      auth: true,
      formData: false,
    );
    try {
      final response = await dio.get('/file/api/reports/patient-report/');
      return response.data;
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response?.data['detail'] ?? 'Failed to fetch report');
      } else {
        throw Exception('Network error');
      }
    }
  }
}
