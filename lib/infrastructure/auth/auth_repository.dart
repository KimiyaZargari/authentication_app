import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:authentication_app/domain/auth/auth_failure.dart';
import 'package:authentication_app/domain/auth/credentials.dart';
import 'package:authentication_app/domain/auth/i_auth_repository.dart';
import 'package:injectable/injectable.dart';


@LazySingleton(as: IAuthRepository)
class AuthRepository implements IAuthRepository {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;


  AuthRepository(
    this._firebaseAuth,
    this._googleSignIn,
  );

  @override
  Future<String?> getSignedInUser() async => _firebaseAuth.currentUser?.email;

  @override
  Future<Either<AuthFailure, String>> registerWithEmailAndPassword(
      Credentials credentials) async {
    try {
     final cred =  await _firebaseAuth.createUserWithEmailAndPassword(
          email: credentials.email, password: credentials.password);
      return right(cred.user!.email!);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return left(const AuthFailure.emailAlreadyInUse());
      } else {
        return left(const AuthFailure.serverError());
      }
    }
  }

  @override
  Future<Either<AuthFailure, String>> signInWithEmailAndPassword(
      Credentials credentials) async {
    try {
    final cred =   await _firebaseAuth.signInWithEmailAndPassword(
          email: credentials.email, password: credentials.password);
      return right(cred.user!.email!);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
        return left(const AuthFailure.invalidEmailAndPasswordCombination());
      } else {
        return left(const AuthFailure.serverError());
      }
    }
  }

  @override
  Future<Either<AuthFailure, String>> signInWithGoogle() async {
    try {
      final user = await _googleSignIn.signIn();
      if (user == null) {
        return left(const AuthFailure.cancelledByUser());
      }

      final googleAuthentication = await user.authentication;

      final authCredential = GoogleAuthProvider.credential(
        idToken: googleAuthentication.idToken,
        accessToken: googleAuthentication.accessToken,
      );

    final cred =   await _firebaseAuth.signInWithCredential(authCredential);
      return right(cred.user!.email!);
    } on FirebaseAuthException catch (_) {
      return left(const AuthFailure.serverError());
    }
  }

  @override
  Future<Unit> logout() {
    return Future.wait(
            [ _firebaseAuth.signOut(), _googleSignIn.signOut()])
        .then((value) => unit);
  }
}
