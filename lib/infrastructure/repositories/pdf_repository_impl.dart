import 'package:cps_patient/domain/repositories/pdf_repository.dart';
import 'package:cps_patient/infrastructure/datasources/pdf_datasource.dart';
import '../../domain/entities/pdf_file.dart';

class PdfRepositoryImpl implements PdfRepository {
  final PdfDataSource dataSource;

  PdfRepositoryImpl(this.dataSource);

  @override
  Future<PdfFile> getPdf(int id) async {
    final data = await dataSource.fetchPdf(id);
    return PdfFile(data: data);
  }
}
