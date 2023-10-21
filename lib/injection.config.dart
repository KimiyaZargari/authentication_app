// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:authentication_app/application/auth/login_bloc.dart' as _i7;
import 'package:authentication_app/application/home/home_bloc.dart' as _i8;
import 'package:authentication_app/domain/auth/i_auth_repository.dart' as _i5;
import 'package:authentication_app/infrastructure/auth/auth_repository.dart'
    as _i6;
import 'package:authentication_app/infrastructure/core/firebase_injectable_module.dart'
    as _i9;
import 'package:firebase_auth/firebase_auth.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:google_sign_in/google_sign_in.dart' as _i4;
import 'package:injectable/injectable.dart' as _i2;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final firebaseInjectableModule = _$FirebaseInjectableModule();
    gh.lazySingleton<_i3.FirebaseAuth>(
        () => firebaseInjectableModule.firebaseAuth);
    gh.lazySingleton<_i4.GoogleSignIn>(
        () => firebaseInjectableModule.googleSignIn);
    gh.lazySingleton<_i5.IAuthRepository>(() => _i6.AuthRepository(
          gh<_i3.FirebaseAuth>(),
          gh<_i4.GoogleSignIn>(),
        ));
    gh.factory<_i7.LoginBloc>(() => _i7.LoginBloc(gh<_i5.IAuthRepository>()));
    gh.factory<_i8.HomeBloc>(() => _i8.HomeBloc(gh<_i5.IAuthRepository>()));
    return this;
  }
}

class _$FirebaseInjectableModule extends _i9.FirebaseInjectableModule {}
