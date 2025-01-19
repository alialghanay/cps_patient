import 'package:cps_patient/application/blocs/pdf_bloc.dart';
import 'package:cps_patient/infrastructure/datasources/pdf_datasource.dart';
import 'package:cps_patient/infrastructure/repositories/pdf_repository_impl.dart';
import 'package:get_it/get_it.dart';
import '../infrastructure/local/secure_storage.dart';
import '../domain/repositories/auth_repository.dart';
import '../infrastructure/datasources/auth_datasource.dart';
import '../application/blocs/auth_bloc.dart';
import '../application/usecase/login_usecase.dart';
import '../infrastructure/repositories/auth_repository_impl.dart';
import '../domain/repositories/report_repository.dart';
import '../infrastructure/datasources/report_datasource.dart';
import '../infrastructure/repositories/report_repository_impl.dart';
import '../application/usecase/get_patient_report.dart';
import '../application/blocs/report_bloc.dart';
import 'package:cps_patient/core/di/configure_dependencies.dart';

final getIt = GetIt.instance;

void configureDependencies() {
  // Register SecureStorage
  getIt.registerLazySingleton(() => SecureStorage());

  // Register DioProvider
  getIt.registerLazySingleton(() => DioProvider(getIt<SecureStorage>()));

  // Data layer for Auth
  getIt.registerLazySingleton(() => AuthDataSource(getIt<DioProvider>()));

  // Domain layer for Auth
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(getIt<AuthDataSource>(), getIt<SecureStorage>()),
  );
  getIt.registerLazySingleton(() => LoginUseCase(getIt()));

  // Bloc for Auth
  getIt.registerFactory(() => AuthBloc(getIt()));

  // Data layer for Report
  getIt.registerLazySingleton(() => ReportDataSource(getIt<DioProvider>()));

  // Domain layer for Report
  getIt.registerLazySingleton<ReportRepository>(
    () => ReportRepositoryImpl(getIt<ReportDataSource>()),
  );
  getIt.registerLazySingleton(() => GetPatientReport(getIt()));

  // Bloc for Report
  getIt.registerFactory(() => ReportBloc(getIt()));

  // Pdf Data layer
  getIt.registerLazySingleton(() => PdfDataSource(getIt<DioProvider>()));

  // Pdf Domain layer
  getIt.registerLazySingleton(() => PdfRepositoryImpl(getIt<PdfDataSource>()));

  // bloc for Pdf
  getIt.registerFactory(() => PdfBloc(getIt()));
}
