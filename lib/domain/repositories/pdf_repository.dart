import 'package:cps_patient/domain/entities/pdf_file.dart';

abstract class PdfRepository {
  Future<PdfFile> getPdf(int id);
}
