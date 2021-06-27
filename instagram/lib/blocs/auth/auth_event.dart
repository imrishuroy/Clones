part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  bool? get stringify => true;

  @override
  List<Object> get props => <Object>[];
}

class AuthUserChanged extends AuthEvent {
  const AuthUserChanged({required this.user});
  final User? user;

  @override
  List<Object> get props => <Object>[user ?? ''];
}

class AuthLogoutRequested extends AuthEvent {}
