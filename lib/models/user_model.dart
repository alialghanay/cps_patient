enum UserType { patient }

class UserModel {
  final String name;
  final String username;
  final UserType userType;
  final String refresh;
  final String access;

  UserModel({
    required this.name,
    required this.username,
    required this.userType,
    required this.refresh,
    required this.access,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      username: json['username'],
      userType: _parseUserType(json['userType']),
      refresh: json['refresh'],
      access: json['access'],
    );
  }

  static UserType _parseUserType(String userType) {
    switch (userType.toLowerCase()) {
      case 'patient':
        return UserType.patient;
      default:
        throw Exception('Unsupported user type: $userType');
    }
  }
}

class ForgetPasswordStepOneRequest {
  final int step;
  final String email;
  final String username;
  final UserType userType;

  ForgetPasswordStepOneRequest({
    required this.step,
    required this.email,
    required this.username,
    required this.userType,
  });
}

class ForgetPasswordStepOneResponse {
  final String detail;

  ForgetPasswordStepOneResponse({
    required this.detail,
  });
}

class ForgetPasswordStepTwoRequest {
  final int step;
  final String email;
  final String username;
  final UserType userType;
  final String otpCode;

  ForgetPasswordStepTwoRequest({
    required this.step,
    required this.email,
    required this.username,
    required this.userType,
    required this.otpCode,
  });
}

class ForgetPasswordStepTwoResponse {
  final String token;
  final String detail;

  ForgetPasswordStepTwoResponse({
    required this.token,
    required this.detail,
  });
}

class ForgetPasswordStepThreeRequest {
  final int step;
  final String token;
  final String newPassword;
  final String repeatPassword;

  ForgetPasswordStepThreeRequest({
    required this.step,
    required this.token,
    required this.newPassword,
    required this.repeatPassword,
  });
}

class ForgetPasswordStepThreeResponse {
  final String detail;

  ForgetPasswordStepThreeResponse({
    required this.detail,
  });
}

class SimpleUser {
  final int id;
  final String username;
  final String email;

  SimpleUser({required this.id, required this.username, required this.email});

  factory SimpleUser.fromJson(Map<String, dynamic> json) {
    return SimpleUser(
      id: json['id'] ?? 0,
      username: json['username'] ?? '',
      email: json['email'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
    };
  }
}
