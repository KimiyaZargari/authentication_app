

import 'package:authentication_app/domain/auth/i_auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'splash_event.dart';

part 'splash_state.dart';
@injectable
class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final IAuthRepository repository;

  SplashBloc(this.repository) : super(SplashInitial()) {
    on<SplashEvent>((event, emit) async {
      switch (event.runtimeType) {
        case OnSplashPageInitiated:
          await Future.delayed(Duration(seconds: 2));
          final user = await repository.getSignedInUser();
          if (user == null)
            emit(NoUserFound());
          else
            emit(UserSignedIn(user));
      }
    });
  }
}
