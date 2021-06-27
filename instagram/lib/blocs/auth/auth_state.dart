part of 'auth_bloc.dart';

enum AuthStatus { unknown, authenticated, unauthenticated }

class AuthState extends Equatable {
  const AuthState({
    this.user,
    this.status = AuthStatus.unknown,
  });

  factory AuthState.unknown() => const AuthState();

  factory AuthState.authenticated({required User user}) =>
      AuthState(user: user, status: AuthStatus.authenticated);

  factory AuthState.unauthenticated() =>
      const AuthState(status: AuthStatus.unauthenticated);

  final User? user;
  final AuthStatus status;

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => <Object>[user ?? '', status];
}
