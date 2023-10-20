import 'package:dartz/dartz.dart';
import 'package:authentication_app/domain/auth/auth_failure.dart';
import 'package:authentication_app/domain/auth/credentials.dart';

abstract class IAuthRepository {
  Future<Either<AuthFailure, Unit>> registerWithEmailAndPassword(
      Credentials credentials);

  Future<Either<AuthFailure, Unit>> signInWithEmailAndPassword(
      Credentials credentials);

  Future<Either<AuthFailure, Unit>> signInWithGoogle();

  Future< String?> getSignedInUser();

  Future< Unit> logout();
}
