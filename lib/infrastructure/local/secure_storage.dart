import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  // Save token
  Future<void> saveToken(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  // Retrieve token
  Future<String?> getToken(String key) async {
    return await _storage.read(key: key);
  }

  // Delete token
  Future<void> deleteToken(String key) async {
    await _storage.delete(key: key);
  }

  // Delete all stored values
  Future<void> clearStorage() async {
    await _storage.deleteAll();
  }
}
