import '../../domain/entities/report.dart';
import '../../domain/repositories/report_repository.dart';

class GetPatientReport {
  final ReportRepository repository;

  GetPatientReport(this.repository);

  Future<Report> call() {
    return repository.getPatientReport();
  }
}
