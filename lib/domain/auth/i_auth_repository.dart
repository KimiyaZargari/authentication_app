import 'package:dartz/dartz.dart';
import 'package:authentication_app/domain/auth/auth_failure.dart';
import 'package:authentication_app/domain/auth/credentials.dart';

abstract class IAuthRepository {
  Future<Either<AuthFailure, String>> registerWithEmailAndPassword(
      Credentials credentials);

  Future<Either<AuthFailure, String>> signInWithEmailAndPassword(
      Credentials credentials);

  Future<Either<AuthFailure, String>> signInWithGoogle();

  Future<String?> getSignedInUser();

  Future<Unit> logout();
}
