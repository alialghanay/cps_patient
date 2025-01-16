import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import '../data/datasources/auth_remote_datasource.dart';
import '../data/repositories/auth_repository_impl.dart';
import '../domain/repositories/auth_repository.dart';
import '../domain/usecases/login_usecase.dart';
import '../presentation/blocs/auth_bloc.dart';

final getIt = GetIt.instance;

void configureDependencies() {
  // Dio instance
  getIt.registerLazySingleton(() => Dio());

  // Data layer
  getIt.registerLazySingleton(() => AuthRemoteDataSource(getIt()));

  // Domain layer
  getIt
      .registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(getIt()));
  getIt.registerLazySingleton(() => LoginUseCase(getIt()));

  // Bloc
  getIt.registerFactory(() => AuthBloc(getIt()));
}
