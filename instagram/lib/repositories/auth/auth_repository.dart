import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:instagram/config/paths.dart';
import 'package:instagram/models/failure.dart';
import 'package:instagram/repositories/auth/base_auth_repository.dart';

class AuthRepository extends BaseAuthRepository {
  AuthRepository({
    FirebaseFirestore? firebaseFirestore,
    FirebaseAuth? firebaseAuth,
  })  : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _firestore = firebaseFirestore ?? FirebaseFirestore.instance;

  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  @override
  Stream<User?> get user => _firebaseAuth.userChanges();

  @override
  Future<User?> signUpWithEmail({
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final User? user = userCredential.user;
      if (user != null) {
        _firestore.collection(Paths.users).doc(user.uid).set(
          <String, dynamic>{
            'username': username,
            'email': email,
            'following': 0,
            'followers': 0,
          },
        );
      }

      return user;
    } on FirebaseAuthException catch (error) {
      print('Sign Up FirebaseAuth Exception - ${error.message}');
      throw Failure(
          message: error.message ?? 'Something went wrong', code: error.code);
    } on PlatformException catch (error) {
      print('Sign Up Platform Exception - ${error.message}');
      throw Failure(
          message: error.message ?? 'Something went wrong', code: error.code);
    } catch (error) {
      print('Sign Up Error - ${error.toString}');
      throw const Failure(
        message: 'Something went wrong',
      );
    }
  }

  @override
  Future<User?> logInWithEmail(
      {required String email, required String password}) async {
    try {
      final UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (error) {
      print('Sign In FirebaseAuth Exception - ${error.message}');
      throw Failure(
          message: error.message ?? 'Something went wrong', code: error.code);
    } on PlatformException catch (error) {
      print('Sign IN Platform Exception - ${error.message}');
      throw Failure(
          message: error.message ?? 'Something went wrong', code: error.code);
    } catch (error) {
      print('SignIn Error - ${error.toString}');
      throw const Failure(
        message: 'Something went wrong',
      );
    }
  }

  @override
  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }
}
