import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/pdf_file.dart';
import '../usecase/fetch_pdf_usecase.dart';

class FetchPdfEvent {
  final String token;
  final int id;

  FetchPdfEvent(this.token, this.id);
}

class PdfState {}

class PdfLoading extends PdfState {}

class PdfLoaded extends PdfState {
  final PdfFile pdfFile;

  PdfLoaded(this.pdfFile);
}

class PdfError extends PdfState {
  final String message;

  PdfError(this.message);
}

class PdfBloc extends Bloc<FetchPdfEvent, PdfState> {
  final FetchPdfUseCase fetchPdfUseCase;

  PdfBloc(this.fetchPdfUseCase) : super(PdfLoading()) {
    on<FetchPdfEvent>((event, emit) async {
      emit(PdfLoading());
      try {
        final pdfFile = await fetchPdfUseCase(event.id);
        emit(PdfLoaded(pdfFile));
      } catch (e) {
        emit(PdfError(e.toString()));
      }
    });
  }
}
