import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:instagram/models/failure.dart';
import 'package:instagram/repositories/auth/auth_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(LoginState.initial());

  final AuthRepository _authRepository;

  void emailChanged(String value) {
    emit(state.copyWith(email: value, status: LoginStatus.initial));
  }

  void passwordChanged(String value) {
    emit(state.copyWith(password: value, status: LoginStatus.initial));
  }

  Future<void> loginWithEmail() async {
    if (!state.isFormValid || state.status == LoginStatus.submitting) return;
    emit(state.copyWith(status: LoginStatus.submitting));
    try {
      await _authRepository.logInWithEmail(
          email: state.email!, password: state.password!);
      emit(state.copyWith(status: LoginStatus.succuss));
    } on Failure catch (error) {
      print(error.toString());
      emit(state.copyWith(status: LoginStatus.error, failure: error));
    }
  }
}
