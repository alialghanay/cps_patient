enum Gender { male, female, other }

class Patient {
  final int id;
  final String name;
  final String idOrPassport;
  final int nationality;
  final int city;
  final int residence;
  final String? lastLogin;
  final bool isSuperuser;
  final String email;
  final bool isStaff;
  final bool isActive;
  final String dateJoined;
  final String phoneNumber;
  final String address;
  final String fullNameInArabic;
  final String motherName;
  final String birthDate;
  final Gender gender;
  final List<dynamic> groups;
  final List<dynamic> userPermissions;

  Patient({
    required this.id,
    required this.name,
    required this.idOrPassport,
    required this.nationality,
    required this.city,
    required this.residence,
    this.lastLogin,
    required this.isSuperuser,
    required this.email,
    required this.isStaff,
    required this.isActive,
    required this.dateJoined,
    required this.phoneNumber,
    required this.address,
    required this.fullNameInArabic,
    required this.motherName,
    required this.birthDate,
    required this.gender,
    required this.groups,
    required this.userPermissions,
  });

  /// Factory constructor to create a `Patient` from JSON
  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      idOrPassport: json['idOrPassport'] ?? '',
      nationality: json['nationality'] ?? 0,
      city: json['city'] ?? 0,
      residence: json['residence'] ?? 0,
      lastLogin: json['lastLogin'],
      isSuperuser: json['isSuperuser'] ?? false,
      email: json['email'] ?? '',
      isStaff: json['isStaff'] ?? false,
      isActive: json['isActive'] ?? false,
      dateJoined: json['dateJoined'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      address: json['address'] ?? '',
      fullNameInArabic: json['fullNameInArabic'] ?? '',
      motherName: json['motherName'] ?? '',
      birthDate: json['birthDate'] ?? '',
      gender: _parseGender(json['gender']), // Parse the gender field correctly
      groups: json['groups'] ?? [],
      userPermissions: json['userPermissions'] ?? [],
    );
  }

  /// Helper method to parse gender from JSON
  static Gender _parseGender(String? genderString) {
    if (genderString == null) return Gender.other;
    switch (genderString.toLowerCase()) {
      case 'male':
        return Gender.male;
      case 'female':
        return Gender.female;
      default:
        return Gender.other; // Default to 'other' for unknown values
    }
  }

  /// Method to convert a `Patient` object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'idOrPassport': idOrPassport,
      'nationality': nationality,
      'city': city,
      'residence': residence,
      'lastLogin': lastLogin,
      'isSuperuser': isSuperuser,
      'email': email,
      'isStaff': isStaff,
      'isActive': isActive,
      'dateJoined': dateJoined,
      'phoneNumber': phoneNumber,
      'address': address,
      'fullNameInArabic': fullNameInArabic,
      'motherName': motherName,
      'birthDate': birthDate,
      'gender': gender.name, // Convert enum to string
      'groups': groups,
      'userPermissions': userPermissions,
    };
  }
}
