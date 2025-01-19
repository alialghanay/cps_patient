import 'package:bloc/bloc.dart';
import 'package:cps_patient/application/usecase/login_usecase.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/user.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;

  AuthBloc(this.loginUseCase) : super(AuthInitial()) {
    on<LoginEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final user = await loginUseCase(event.username, event.password);
        emit(AuthSuccess(user));
      } catch (error) {
        emit(AuthFailure(error.toString()));
      }
    });
  }
}
