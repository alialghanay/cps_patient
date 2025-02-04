import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:cps_patient/services/auth_service_token.dart';

class DioService {
  late Dio _dio;
  final String baseUrl;
  final SharedPrefService _sharedPrefService = SharedPrefService();

  DioService({String? customBaseUrl})
      : baseUrl = customBaseUrl ?? dotenv.env['BASE_URL']! {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        headers: {
          'Content-Type': 'application/json',
        },
        connectTimeout: const Duration(milliseconds: 100000),
        receiveTimeout: const Duration(milliseconds: 100000),
      ),
    );

    _addInterceptors();
  }

  void _addInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // Add token if `auth` is true
          if (options.extra['auth'] == true) {
            final token = await _sharedPrefService.getToken();
            if (token != null) {
              options.headers['Authorization'] = 'Bearer $token';
            }
          }
          return handler.next(options);
        },
        onResponse: (response, handler) {
          // Handle successful responses
          return handler.next(response);
        },
        onError: (DioException error, handler) {
          // Handle errors
          if (error.response?.statusCode == 401 ||
              error.response?.statusCode == 403) {
            // Handle auto sign-out logic here
            print('Unauthorized! Logging out...');
            // autoSignOut();
          }
          return handler.next(error);
        },
      ),
    );
  }

  Future<Response> get(String path,
      {Map<String, dynamic>? queryParameters,
      bool auth = false,
      String contentType = 'application/json'}) async {
    return await _dio.get(
      path,
      queryParameters: queryParameters,
      options: Options(
        headers: {'Content-Type': contentType},
        extra: {'auth': auth},
      ),
    );
  }

  Future<Response> post(String path,
      {dynamic data,
      bool auth = false,
      String contentType = 'application/json'}) async {
    return await _dio.post(
      path,
      data: data,
      options: Options(
        headers: {'Content-Type': contentType},
        extra: {'auth': auth},
      ),
    );
  }

  Future<Response> put(String path,
      {dynamic data,
      bool auth = false,
      String contentType = 'application/json'}) async {
    return await _dio.put(
      path,
      data: data,
      options: Options(
        headers: {'Content-Type': contentType},
        extra: {'auth': auth},
      ),
    );
  }

  Future<Response> delete(String path,
      {dynamic data,
      bool auth = false,
      String contentType = 'application/json'}) async {
    return await _dio.delete(
      path,
      data: data,
      options: Options(
        headers: {'Content-Type': contentType},
        extra: {'auth': auth},
      ),
    );
  }

  Dio get dio => _dio;
}
