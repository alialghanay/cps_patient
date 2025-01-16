import '../../domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required String name,
    required String username,
    required String userType,
    required String refresh,
    required String access,
  }) : super(
          name: name,
          username: username,
          userType: userType,
          refresh: refresh,
          access: access,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      username: json['username'],
      userType: json['userType'],
      refresh: json['refresh'],
      access: json['access'],
    );
  }
}
