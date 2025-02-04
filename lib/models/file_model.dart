import 'package:cps_patient/models/clinic_data.dart';
import 'package:cps_patient/models/created_by.dart';
import 'package:cps_patient/models/patient.dart';
import 'package:cps_patient/models/sample.dart';
import 'package:cps_patient/models/updated_by.dart';
import 'package:cps_patient/models/diagnosis.dart'; // Add Diagnosis model
import 'package:cps_patient/models/user_model.dart'; // Reuse for assignedSho & assignedDataEntry

enum FileStatus { pending, assigned, waiting_approval, ready_download }

class FileModel {
  final int id;
  final CreatedBy? createdBy;
  final UpdatedBy? updatedBy;
  final Patient patient;
  final ClinicData clinicData;
  final Diagnosis? diagnosis; // ✅ Change to Diagnosis model
  final List<Sample> sample;
  final SimpleUser? assignedSho; // ✅ Change to User model
  final SimpleUser? assignedDataEntry; // ✅ Change to User model
  final String createdAt;
  final String fileNo;
  final FileStatus status;
  final int? referringDoctors; // ✅ Change to nullable int
  final String? nationalityName;

  FileModel({
    required this.id,
    this.createdBy,
    this.updatedBy,
    required this.patient,
    required this.clinicData,
    this.diagnosis,
    required this.sample,
    this.assignedSho,
    this.assignedDataEntry,
    required this.createdAt,
    required this.fileNo,
    required this.status,
    this.referringDoctors,
    this.nationalityName,
  });

  /// Factory constructor to create `FileModel` from JSON
  factory FileModel.fromJson(Map<String, dynamic> json) {
    print("Parsing JSON: $json"); // Debugging

    return FileModel(
      id: json['id'] ?? 0,
      createdBy: json['createdBy'] != null
          ? CreatedBy.fromJson(json['createdBy'])
          : null,
      updatedBy: json['updatedBy'] != null
          ? UpdatedBy.fromJson(json['updatedBy'])
          : null,
      patient: Patient.fromJson(json['patient']),
      clinicData: ClinicData.fromJson(json['clinicData']),
      diagnosis: json['diagnosis'] != null
          ? Diagnosis.fromJson(json['diagnosis']) // ✅ Parse as object
          : null,
      sample: (json['sample'] as List<dynamic>?)
              ?.map((e) => Sample.fromJson(e))
              .toList() ??
          [],
      assignedSho: json['assignedSho'] != null
          ? SimpleUser.fromJson(json['assignedSho']) // ✅ Use User model
          : null,
      assignedDataEntry: json['assignedDataEntry'] != null
          ? SimpleUser.fromJson(json['assignedDataEntry']) // ✅ Use User model
          : null,
      createdAt: json['createdAt'] ?? '',
      fileNo: json['fileNo'] ?? '',
      status: _parseFileStatus(json['status']), // Handle null safely
      referringDoctors:
          json['referringDoctors'] as int?, // ✅ Convert to nullable int
      nationalityName: json['nationalityName'], // ✅ Parse nationalityName
    );
  }

  /// Method to convert a `FileModel` to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdBy': createdBy?.toJson(),
      'updatedBy': updatedBy?.toJson(),
      'patient': patient.toJson(),
      'clinicData': clinicData.toJson(),
      'diagnosis': diagnosis?.toJson(), // ✅ Convert to JSON
      'sample': sample.map((e) => e.toJson()).toList(),
      'assignedSho': assignedSho?.toJson(), // ✅ Convert to JSON
      'assignedDataEntry': assignedDataEntry?.toJson(), // ✅ Convert to JSON
      'createdAt': createdAt,
      'fileNo': fileNo,
      'status': status.name, // Convert `status` to its string representation
      'referringDoctors': referringDoctors, // ✅ Convert back to int
      'nationalityName': nationalityName,
    };
  }

  /// Helper method to parse `FileStatus` safely
  static FileStatus _parseFileStatus(String? status) {
    switch (status?.toLowerCase()) {
      // ✅ Handle null safely
      case 'pending':
        return FileStatus.pending;
      case 'assigned':
        return FileStatus.assigned;
      case 'waiting_approval':
        return FileStatus.waiting_approval;
      case 'ready_download':
        return FileStatus.ready_download;
      default:
        return FileStatus.pending; // ✅ Default value
    }
  }
}
