// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:authentication_app/presentation/auth/page_login.dart' as _i2;
import 'package:authentication_app/presentation/home/page_home.dart' as _i1;
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:flutter/material.dart' as _i4;

abstract class $AppRouter extends _i3.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i3.PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      final args = routeData.argsAs<HomeRouteArgs>();
      return _i3.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.HomePage(
          args.email,
          key: args.key,
        ),
      );
    },
    LoginRoute.name: (routeData) {
      return _i3.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.LoginPage(),
      );
    },
  };
}

/// generated route for
/// [_i1.HomePage]
class HomeRoute extends _i3.PageRouteInfo<HomeRouteArgs> {
  HomeRoute({
    required String email,
    _i4.Key? key,
    List<_i3.PageRouteInfo>? children,
  }) : super(
          HomeRoute.name,
          args: HomeRouteArgs(
            email: email,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i3.PageInfo<HomeRouteArgs> page =
      _i3.PageInfo<HomeRouteArgs>(name);
}

class HomeRouteArgs {
  const HomeRouteArgs({
    required this.email,
    this.key,
  });

  final String email;

  final _i4.Key? key;

  @override
  String toString() {
    return 'HomeRouteArgs{email: $email, key: $key}';
  }
}

/// generated route for
/// [_i2.LoginPage]
class LoginRoute extends _i3.PageRouteInfo<void> {
  const LoginRoute({List<_i3.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i3.PageInfo<void> page = _i3.PageInfo<void>(name);
}
