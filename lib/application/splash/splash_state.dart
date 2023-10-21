part of 'splash_bloc.dart';

@immutable
abstract class SplashState {}

class SplashInitial extends SplashState {}

class UserSignedIn extends SplashState {
  final String email;

  UserSignedIn(this.email);
}

class NoUserFound extends SplashState {}
