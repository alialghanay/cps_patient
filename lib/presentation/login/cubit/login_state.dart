// lib/presentation/login/cubit/login_state.dart

import 'package:cps_patient/models/user_model.dart';
import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final UserModel patient;

  const LoginSuccess(this.patient);

  @override
  List<Object?> get props => [patient];
}

class LoginFailure extends LoginState {
  final String errorMessage;

  const LoginFailure(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
