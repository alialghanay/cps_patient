import 'package:cps_patient/models/file_model.dart';

abstract class FileRepository {
  Future<FileModel> fetchPatientReport();
}
