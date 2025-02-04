import 'package:cps_patient/models/file_model.dart';
import 'package:cps_patient/services/dio_service.dart';
import 'package:cps_patient/services/auth_service_token.dart';
import 'package:dio/dio.dart';

import 'get_file_repostry.dart';

class FileRepositoryImpl implements FileRepository {
  final DioService _dioService = DioService();
  final SharedPrefService _sharedPrefService = SharedPrefService();

  FileRepositoryImpl();

  @override
  Future<FileModel> fetchPatientReport() async {
    try {
      // Retrieve the token from secure storage
      final token = await _sharedPrefService.getToken();
      if (token == null || token.isEmpty) {
        throw Exception('0: Authentication Error: Token not found.');
      }

      // Use DioService to make the API call
      final response = await _dioService.get(
        '/file/api/reports/patient-report/',
        auth: true, // Ensures the token is included in the request
      );
      if (response.statusCode == 200) {
        final responseBody = response.data;
        return FileModel.fromJson(responseBody);
      } else {
        // Extract error message from response
        final errorMessage =
            response.data['detail'] ?? 'Failed to fetch report.';
        // Embed status code in the exception message
        throw Exception('${response.statusCode}: $errorMessage');
      }
    } catch (e) {
      if (e is DioException) {
        if (e.response != null) {
          // Handle server errors
          final statusCode = e.response?.statusCode ?? 0;
          final errorMessage = e.response?.data['detail'] ?? 'Unknown error.';
          throw Exception('$statusCode: $errorMessage');
        } else {
          // Handle network errors
          throw Exception(
              '0: Network Error: Please check your internet connection and try again.');
        }
      } else if (e is FormatException) {
        // JSON parsing errors
        throw Exception('0: Data Format Error: Unexpected response format.');
      } else {
        // Other unforeseen errors
        throw Exception('0: An unexpected error occurred. Please try again.');
      }
    }
  }
}
