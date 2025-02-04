import 'package:cps_patient/models/user_model.dart';

abstract class LoginRepository {
  Future<UserModel> login(String username, String password);
}
