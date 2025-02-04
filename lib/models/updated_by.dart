class UpdatedBy {
  final int id;
  final String username;
  final String email;
  final String role;

  UpdatedBy({
    required this.id,
    required this.username,
    required this.email,
    required this.role,
  });

  factory UpdatedBy.fromJson(Map<String, dynamic> json) {
    return UpdatedBy(
      id: json['id'] ?? 0,
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      role: json['role'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'role': role,
    };
  }
}
