import 'package:authentication_app/application/splash/splash_bloc.dart';
import 'package:authentication_app/injection.dart';
import 'package:authentication_app/presentation/routes/router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

@RoutePage()
class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocProvider(
              create: (context) =>
              getIt<SplashBloc>()
                ..add(OnSplashPageInitiated()),
              child: BlocListener<SplashBloc, SplashState>(
                listener: (context, state) {
                 if(state is UserSignedIn)
                   context.replaceRoute(HomeRoute(email: state.email));
                 else if(state is NoUserFound)
                   context.replaceRoute(LoginRoute());
                },
                child: Padding(

                  padding: const EdgeInsets.only(bottom: 60.0),
                  child: Lottie.asset('assets/animation_lnjd0jn7.json'),
                ),
              ),
            ),
          ],
        ));
  }
}
