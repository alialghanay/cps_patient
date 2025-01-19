import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_datasource.dart';
import '../local/secure_storage.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource dataSource;
  final SecureStorage storage;

  AuthRepositoryImpl(this.dataSource, this.storage);

  @override
  Future<User> login(String username, String password) async {
    final data = await dataSource.login(username, password);

    // Check if userType is "patient"
    if (data['userType'] != 'patient') {
      throw Exception('Unauthorized: Only patients can access the app.');
    }

    // Save tokens using SecureStorage
    await storage.saveToken('access', data['access']);
    await storage.saveToken('refresh', data['refresh']);

    return User(
      name: data['name'],
      username: data['username'],
      userType: data['userType'],
      access: data['access'],
      refresh: data['refresh'],
    );
  }
}
