import 'package:cps_patient/domain/entities/report.dart';
import 'package:cps_patient/domain/repositories/report_repository.dart';
import '../datasources/report_datasource.dart';

class ReportRepositoryImpl implements ReportRepository {
  final ReportDataSource dataSource;

  ReportRepositoryImpl(this.dataSource);

  @override
  Future<Report> getPatientReport() async {
    final data = await dataSource.fetchReport();

    // Map API response to `Report` entity
    return Report(
      id: data['id'],
      fileNo: data['fileNo'],
      status: data['status'],
      patient: Patient(
        id: data['patient']['id'],
        name: data['patient']['name'],
        idOrPassport: data['patient']['idOrPassport'],
        gender: data['patient']['gender'],
        birthDate: data['patient']['birthDate'],
        phoneNumber: data['patient']['phoneNumber'],
      ),
      clinicData: ClinicData(
        medicalFacilityName: data['clinicData']['medicalFacilityName'],
        doctor: data['clinicData']['doctor'],
        history: data['clinicData']['histroy'],
        hivStatus: data['clinicData']['hivStatus'],
        hcvStatus: data['clinicData']['hcvStatus'],
        hbvStatus: data['clinicData']['hbvStatus'],
      ),
      samples: (data['sample'] as List)
          .map((sample) => Sample(
                sampleType: sample['sampleType'],
                specimen: sample['specimen'],
              ))
          .toList(),
    );
  }
}
