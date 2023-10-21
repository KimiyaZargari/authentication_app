import 'dart:async';

import 'package:authentication_app/domain/auth/credentials.dart';
import 'package:authentication_app/domain/auth/i_auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dartz/dartz.dart';
import 'package:authentication_app/domain/auth/auth_failure.dart';
import 'package:flutter/foundation.dart';

part 'login_events.dart';

part 'login_state.dart';

part 'login_bloc.freezed.dart';

@injectable
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final IAuthRepository repository;

  LoginBloc(this.repository) : super(LoginState.initial()) {
    on<LoginEvent>(mapEventToState);
  }

  mapEventToState(LoginEvent event, Emitter<LoginState> emit) async {
    final LoginState newState = await event.map(
      emailChanged: (e) {
        return state.copyWith(
          email: e.emailStr,
          authFailureOrSuccess: null,
        );
      },
      passwordChanged: (e) {
        return state.copyWith(
          password: e.passwordStr,
          authFailureOrSuccess: null,
        );
      },
      registerWithEmailAndPasswordPressed: (e) async {
        return await _performActionOnAuthFacadeWithEmailAndPassword(
            (repository.registerWithEmailAndPassword), emit);
      },
      signInWithEmailAndPasswordPressed: (e) async {
        return (await _performActionOnAuthFacadeWithEmailAndPassword(
            repository.signInWithEmailAndPassword, emit));
      },
      signInWithGooglePressed: (e) async {
        emit(state.copyWith(
          waitingForGoogle: true,
          authFailureOrSuccess: null,
        ));
        final failureOrSuccess = await repository.signInWithGoogle();
        return state.copyWith(
          waitingForGoogle: false,
          authFailureOrSuccess: failureOrSuccess,
        );
      },
      startAutoValidate: (StartAutoValidate value) {
        return state.copyWith(showValidationMessages: true);
      },
      switchUserType: (SwitchUserType value) {
        return state.copyWith(isNewUser: !state.isNewUser);
      },
    );
    emit(newState);
  }

  Future<LoginState> _performActionOnAuthFacadeWithEmailAndPassword(
      Future<Either<AuthFailure, String>> Function(Credentials credentials)
      forwardedCall,
      Emitter<LoginState> emit) async {
    Either<AuthFailure, String> failureOrSuccess;

    emit(state.copyWith(
      isSubmitting: true,
      authFailureOrSuccess: null,
    ));

    failureOrSuccess = await forwardedCall(
        Credentials(email: state.email, password: state.password));

    return state.copyWith(
      isSubmitting: false,
      authFailureOrSuccess: failureOrSuccess,
    );
  }
}
