part of 'login_cubit.dart';

enum LoginStatus { initial, submitting, succuss, error }

class LoginState extends Equatable {
  const LoginState({
    required this.email,
    required this.password,
    required this.status,
    required this.failure,
  });

  factory LoginState.initial() => const LoginState(
      email: '', password: '', status: LoginStatus.initial, failure: Failure());

  final String? email;
  final String? password;
  final LoginStatus? status;
  final Failure? failure;

  @override
  bool? get stringify => true;
  @override
  List<Object?> get props => <Object?>[email, password, status, failure];

  bool get isFormValid => email!.isNotEmpty && password!.isNotEmpty;

  LoginState copyWith({
    String? email,
    String? password,
    LoginStatus? status,
    Failure? failure,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      failure: failure ?? this.failure,
    );
  }
}
