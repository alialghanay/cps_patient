import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/report.dart';
import '../../application/usecase/get_patient_report.dart';

abstract class ReportState {}

class ReportInitial extends ReportState {}

class ReportLoading extends ReportState {}

class ReportLoaded extends ReportState {
  final Report report;

  ReportLoaded(this.report);
}

class ReportError extends ReportState {
  final String message;

  ReportError(this.message);
}

class ReportEvent {}

class FetchReportEvent extends ReportEvent {}

class ReportBloc extends Bloc<ReportEvent, ReportState> {
  final GetPatientReport getPatientReport;

  ReportBloc(this.getPatientReport) : super(ReportInitial()) {
    on<FetchReportEvent>((event, emit) async {
      emit(ReportLoading());
      try {
        final report = await getPatientReport();
        emit(ReportLoaded(report));
      } catch (e) {
        emit(ReportError(e.toString()));
      }
    });
  }
}
