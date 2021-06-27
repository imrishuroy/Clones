import 'package:firebase_auth/firebase_auth.dart';

abstract class BaseAuthRepository {
  Stream<User?> get user;

  Future<User?> signUpWithEmail({
    required String username,
    required String email,
    required String password,
  });

  Future<User?> logInWithEmail({
    required String email,
    required String password,
  });

  Future<void> logout();
}
