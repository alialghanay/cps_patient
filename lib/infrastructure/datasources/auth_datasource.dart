import 'package:cps_patient/core/di/configure_dependencies.dart';
import 'package:dio/dio.dart';

class AuthDataSource {
  final DioProvider dioProvider;

  AuthDataSource(this.dioProvider);

  Future<Map<String, dynamic>> login(String username, String password) async {
    final dio = dioProvider.createDio(
      baseURL: 'http://127.0.0.1:8000',
      auth: false,
      formData: true,
    );
    try {
      final response = await dio.post(
        '/auth/login/',
        data: {'username': username, 'password': password},
        options: Options(contentType: 'application/x-www-form-urlencoded'),
      );
      return response.data;
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response?.data['detail'] ?? 'Login failed');
      } else {
        throw Exception('Network error');
      }
    }
  }
}
