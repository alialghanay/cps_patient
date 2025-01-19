import 'package:cps_patient/infrastructure/local/secure_storage.dart';
import 'package:flutter/material.dart';

class AutoSignOut {
  final SecureStorage secureStorage = SecureStorage();

  Future<void> execute(BuildContext context) async {
    // Clear all stored tokens and user data
    await secureStorage.clearStorage();

    // Navigate to login page (replace current route stack)
    Navigator.of(context).pushNamedAndRemoveUntil(
      '/login', // Ensure this matches your login page route
      (route) => false,
    );
  }
}
