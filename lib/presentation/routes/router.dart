import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'router.gr.dart';


@AutoRouterConfig(
  replaceInRouteName: 'Page,Route',
)
class AppRouter extends $AppRouter {

  @override
  List<AutoRoute> get routes => [
        AutoRoute(path: '/login', page: LoginRoute.page, initial: true),
        AutoRoute(path: '/home', page: HomeRoute.page),
      ];
}
