import 'package:bloc/bloc.dart';
import 'package:cps_patient/presentation/login/cubit/login_state.dart';

import '../../../domain/login_domain/login_repostry.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginRepository _loginRepository;

  LoginCubit(this._loginRepository) : super(LoginInitial());

  Future<void> login(String username, String password) async {
    try {
      emit(LoginLoading());
      final user = await _loginRepository.login(username, password);
      emit(LoginSuccess(user));
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }
}
