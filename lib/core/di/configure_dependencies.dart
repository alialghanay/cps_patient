import 'package:cps_patient/infrastructure/local/secure_storage.dart';
import 'package:dio/dio.dart';
import '../utils/auto_signout.dart';

class DioProvider {
  final SecureStorage storage;

  DioProvider(this.storage);

  Dio createDio({
    required String baseURL,
    bool auth = false,
    bool formData = false,
  }) {
    final dio = Dio();

    // Set base URL
    dio.options.baseUrl = baseURL;

    // Configure headers
    dio.options.headers = {
      'Content-Type': formData
          ? Headers.formUrlEncodedContentType
          : Headers.jsonContentType,
    };

    // Add authorization header if auth is required
    if (auth) {
      dio.interceptors.add(InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await storage.getToken('access');
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          handler.next(options);
        },
      ));
    }

    // Add interceptors
    dio.interceptors.add(LogInterceptor(
      request: true,
      requestBody: true,
      responseBody: true,
    ));

    dio.interceptors.add(InterceptorsWrapper(
      onError: (DioException error, handler) {
        // Handle 401/403 errors (auto logout)
        if (error.response?.statusCode == 401 ||
            error.response?.statusCode == 403) {
          AutoSignOut(); // Custom sign-out logic
        }
        handler.next(error);
      },
    ));

    return dio;
  }
}
