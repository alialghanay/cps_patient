import 'package:dio/dio.dart';

class AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSource(this.dio);

  Future<Map<String, dynamic>> login(String username, String password) async {
    try {
      // Encode data in application/x-www-form-urlencoded format
      final data = {
        'username': username,
        'password': password,
      };

      final response = await dio.post(
        'http://127.0.0.1:8000/auth/login/',
        data: data,
        options: Options(
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
          },
        ),
      );

      return response.data;
    } on DioError catch (e) {
      if (e.response != null) {
        throw Exception('Login failed: ${e.response?.data}');
      } else {
        print(e);
        throw Exception('Error: ${e.message}');
      }
    }
  }
}
