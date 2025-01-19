import 'package:cps_patient/domain/repositories/pdf_repository.dart';
import '../../domain/entities/pdf_file.dart';

class FetchPdfUseCase {
  final PdfRepository repository;

  FetchPdfUseCase(this.repository);

  Future<PdfFile> call(int id) async {
    return await repository.getPdf(id);
  }
}
