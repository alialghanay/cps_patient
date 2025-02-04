// lib/presentation/report/cubit/report_state.dart

import 'package:equatable/equatable.dart';
import 'package:cps_patient/models/file_model.dart';

abstract class FileState extends Equatable {
  const FileState();

  @override
  List<Object?> get props => [];
}

class FileInitial extends FileState {}

class FileLoading extends FileState {}

class FileSuccess extends FileState {
  final FileModel file;

  const FileSuccess(this.file);

  @override
  List<Object?> get props => [file];
}

class FileFailure extends FileState {
  final String errorMessage;

  const FileFailure(
    this.errorMessage,
  );

  @override
  List<Object?> get props => [errorMessage];
}
