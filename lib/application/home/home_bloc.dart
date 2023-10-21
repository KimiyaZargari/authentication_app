import 'dart:async';

import 'package:authentication_app/domain/auth/i_auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';

part 'home_state.dart';
@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final IAuthRepository repository;

  HomeBloc(this.repository) : super(HomeInitial()) {
    on<HomeEvent>((event, emit) async {
      switch (event.runtimeType) {
        case OnLogoutPressed:
          emit(LoggingOut());
          await repository.logout();
          emit(LoggedOut());
          break;
      }
    });
  }
}
