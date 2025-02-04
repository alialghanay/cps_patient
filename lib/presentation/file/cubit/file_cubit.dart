// lib/presentation/report/cubit/report_cubit.dart

import 'package:bloc/bloc.dart';
import 'package:cps_patient/presentation/file/cubit/file_state.dart';
import '../../../domain/file_domain/get_file_repostry.dart';

class FileCubit extends Cubit<FileState> {
  final FileRepository _reportRepository;

  FileCubit(this._reportRepository) : super(FileInitial());

  Future<void> fetchPatientReport() async {
    try {
      emit(FileLoading());
      final report = await _reportRepository.fetchPatientReport();
      emit(FileSuccess(report));
    } catch (errorMessage) {
      print(errorMessage);
      emit(FileFailure(errorMessage.toString()));
    }
  }
}
