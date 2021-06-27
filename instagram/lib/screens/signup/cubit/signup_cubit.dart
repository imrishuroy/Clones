import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:instagram/models/failure.dart';
import 'package:instagram/repositories/auth/auth_repository.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(SignupState.initial());

  final AuthRepository _authRepository;

  void usernameChanged(String value) {
    emit(state.copyWith(username: value, status: SignupStatus.initial));
  }

  void emailChanged(String value) {
    emit(state.copyWith(email: value, status: SignupStatus.initial));
  }

  void passwordChanged(String value) {
    emit(state.copyWith(password: value, status: SignupStatus.initial));
  }

  Future<void> singUpWithEmail() async {
    if (!state.isFormValid || state.status == SignupStatus.submitting) return;
    emit(state.copyWith(status: SignupStatus.submitting));
    try {
      await _authRepository.signUpWithEmail(
        username: state.username!,
        email: state.email!,
        password: state.password!,
      );
      emit(state.copyWith(status: SignupStatus.succuss));
    } on Failure catch (error) {
      print(error.toString());
      emit(state.copyWith(failure: error, status: SignupStatus.error));
    }
  }
}
