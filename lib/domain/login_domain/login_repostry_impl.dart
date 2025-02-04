import 'package:cps_patient/models/user_model.dart';
import 'package:cps_patient/services/dio_service.dart';
import 'package:cps_patient/services/auth_service_token.dart';
import 'login_repostry.dart';

class LoginRepositoryImpl implements LoginRepository {
  final DioService _dioService = DioService();
  final SharedPrefService _sharedPrefService = SharedPrefService();

  LoginRepositoryImpl();

  @override
  Future<UserModel> login(String username, String password) async {
    try {
      // Use DioService for API call
      final response = await _dioService.post(
        '/auth/login/',
        data: {
          'username': username,
          'password': password,
        },
        contentType: 'application/x-www-form-urlencoded', // If needed
      );

      if (response.statusCode == 200) {
        final responseBody = response.data;
        final accessToken = responseBody['access'];
        // Save token using SharedPrefService
        await _sharedPrefService.saveToken(accessToken);
        await _sharedPrefService.saveName(responseBody['name']);
        await _sharedPrefService.saveUsername(responseBody['username']);
        await _sharedPrefService.saveUserType(responseBody['userType']);

        return UserModel.fromJson(responseBody);
      } else {
        final errorMessage =
            response.data['detail'] ?? 'Login failed. Please try again.';
        return Future.error(errorMessage);
      }
    } catch (e) {
      throw Exception('Failed to login: $e');
    }
  }
}
