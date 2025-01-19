import 'package:equatable/equatable.dart';

class Report extends Equatable {
  final int id;
  final String fileNo;
  final String status;
  final Patient patient;
  final ClinicData clinicData;
  final List<Sample> samples;

  const Report({
    required this.id,
    required this.fileNo,
    required this.status,
    required this.patient,
    required this.clinicData,
    required this.samples,
  });

  @override
  List<Object?> get props => [id, fileNo, status, patient, clinicData, samples];
}

class Patient extends Equatable {
  final int id;
  final String name;
  final String idOrPassport;
  final String gender;
  final String birthDate;
  final String phoneNumber;

  const Patient({
    required this.id,
    required this.name,
    required this.idOrPassport,
    required this.gender,
    required this.birthDate,
    required this.phoneNumber,
  });

  @override
  List<Object?> get props =>
      [id, name, idOrPassport, gender, birthDate, phoneNumber];
}

class ClinicData extends Equatable {
  final String medicalFacilityName;
  final String doctor;
  final String history;
  final bool hivStatus;
  final bool hcvStatus;
  final bool hbvStatus;

  const ClinicData({
    required this.medicalFacilityName,
    required this.doctor,
    required this.history,
    required this.hivStatus,
    required this.hcvStatus,
    required this.hbvStatus,
  });

  @override
  List<Object?> get props =>
      [medicalFacilityName, doctor, history, hivStatus, hcvStatus, hbvStatus];
}

class Sample extends Equatable {
  final String sampleType;
  final String specimen;

  const Sample({
    required this.sampleType,
    required this.specimen,
  });

  @override
  List<Object?> get props => [sampleType, specimen];
}
