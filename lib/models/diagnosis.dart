class Diagnosis {
  final int id;
  final int tumorType;
  final String macroscopic;
  final String microscopic;
  final bool reserve;
  final String timestamp;
  final bool isApproved;
  final String diagnosis;

  Diagnosis({
    required this.id,
    required this.tumorType,
    required this.macroscopic,
    required this.microscopic,
    required this.reserve,
    required this.timestamp,
    required this.isApproved,
    required this.diagnosis,
  });

  factory Diagnosis.fromJson(Map<String, dynamic> json) {
    return Diagnosis(
      id: json['id'] ?? 0,
      tumorType: json['tumorType'] ?? 0,
      macroscopic: json['macroscopic'] ?? '',
      microscopic: json['microscopic'] ?? '',
      reserve: json['reserve'] ?? false,
      timestamp: json['timestamp'] ?? '',
      isApproved: json['isApproved'] ?? false,
      diagnosis: json['diagnosis'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tumorType': tumorType,
      'macroscopic': macroscopic,
      'microscopic': microscopic,
      'reserve': reserve,
      'timestamp': timestamp,
      'isApproved': isApproved,
      'diagnosis': diagnosis,
    };
  }
}
