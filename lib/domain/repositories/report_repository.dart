import '../entities/report.dart';

abstract class ReportRepository {
  Future<Report> getPatientReport();
}
