import 'package:dio/dio.dart';

Dio provideDio() {
  final dio = Dio();
  dio.options.baseUrl = 'http://127.0.0.1:8000';
  dio.options.headers = {'Content-Type': 'application/x-www-form-urlencoded'};
  dio.interceptors.add(LogInterceptor(
    request: true,
    requestBody: true,
    responseBody: true,
  ));
  return dio;
}
