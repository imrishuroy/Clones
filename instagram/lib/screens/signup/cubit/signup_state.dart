part of 'signup_cubit.dart';

enum SignupStatus { initial, submitting, succuss, error }

class SignupState extends Equatable {
  const SignupState({
    required this.username,
    required this.email,
    required this.password,
    required this.failure,
    required this.status,
  });

  factory SignupState.initial() => const SignupState(
        username: '',
        email: '',
        password: '',
        failure: Failure(),
        status: SignupStatus.initial,
      );
  final String? username;
  final String? email;
  final String? password;
  final Failure? failure;
  final SignupStatus? status;

  bool get isFormValid =>
      username!.isNotEmpty && email!.isNotEmpty && password!.isNotEmpty;

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props =>
      <Object?>[username, email, password, failure, status];

  SignupState copyWith({
    String? username,
    String? email,
    String? password,
    Failure? failure,
    SignupStatus? status,
  }) {
    return SignupState(
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      failure: failure ?? this.failure,
      status: status ?? this.status,
    );
  }
}
