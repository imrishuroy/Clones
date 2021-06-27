import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram/repositories/auth/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required AuthRepository authRepository,
  })  : _authRepository = authRepository,
        super(AuthState.unknown()) {
    _userSubscription = _authRepository.user
        .listen((User? user) => add(AuthUserChanged(user: user)));
  }

  final AuthRepository _authRepository;
  StreamSubscription<User?>? _userSubscription;

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
  }

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is AuthUserChanged) {
      yield* _mapAuthUserChangedToState(event);
    } else if (event is AuthLogoutRequested) {
      await _authRepository.logout();
      // yield* _mapAuthLogoutRequestedToState();
    }
  }

  Stream<AuthState> _mapAuthUserChangedToState(AuthUserChanged event) async* {
    yield event.user != null
        ? AuthState.authenticated(user: event.user!)
        : AuthState.unauthenticated();
  }

  // Stream<AuthState> _mapAuthLogoutRequestedToState() async* {
  //   await _authRepository.logout();
  //   yield AuthState.unauthenticated();
  // }
}
