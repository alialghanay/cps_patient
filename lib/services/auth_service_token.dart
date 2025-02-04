import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  static const String _tokenKey = 'token';

  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  Future<void> removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }

  Future<void> saveName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', name);
  }

  Future<String?> getName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('name');
  }

  Future<void> removeName() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('name');
  }

  Future<void> saveUsername(String username) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username);
  }

  Future<String?> getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('username');
  }

  Future<void> removeUsername() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('username');
  }

  Future<void> saveUserType(String userType) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userType', userType);
  }

  Future<String?> getUserType() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('userType');
  }

  Future<void> removeUserType() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('userType');
  }

  Future<void> saveUserId(int userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('userId', userId);
  }

  Future<int?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('userId');
  }

  Future<void> removeUserId() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('userId');
  }
}
