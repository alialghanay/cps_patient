class ClinicData {
  final int id;
  final String medicalFacilityName;
  final String histroy;
  final String doctor;
  final bool hivStatus;
  final bool hcvStatus;
  final bool hbvStatus;
  final int medicalFacility;
  final int department;

  ClinicData({
    required this.id,
    required this.medicalFacilityName,
    required this.histroy,
    required this.doctor,
    required this.hivStatus,
    required this.hcvStatus,
    required this.hbvStatus,
    required this.medicalFacility,
    required this.department,
  });

  factory ClinicData.fromJson(Map<String, dynamic> json) {
    return ClinicData(
      id: json['id'] ?? 0,
      medicalFacilityName: json['medicalFacilityName'] ?? '',
      histroy: json['histroy'] ?? '',
      doctor: json['doctor'] ?? '',
      hivStatus: json['hivStatus'] ?? false,
      hcvStatus: json['hcvStatus'] ?? false,
      hbvStatus: json['hbvStatus'] ?? false,
      medicalFacility: json['medicalFacility'] ?? 0,
      department: json['department'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'medicalFacilityName': medicalFacilityName,
      'histroy': histroy,
      'doctor': doctor,
      'hivStatus': hivStatus,
      'hcvStatus': hcvStatus,
      'hbvStatus': hbvStatus,
      'medicalFacility': medicalFacility,
      'department': department,
    };
  }
}
