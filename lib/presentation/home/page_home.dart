import 'package:authentication_app/application/home/home_bloc.dart';
import 'package:authentication_app/injection.dart';
import 'package:authentication_app/presentation/core/widgets/loading_widget.dart';
import 'package:authentication_app/presentation/core/widgets/page_base.dart';
import 'package:authentication_app/presentation/routes/router.gr.dart';
import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  final String email;

  const HomePage(this.email, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<HomeBloc>(),
      child: PageBase(
        title: 'Home',
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'You are Logged in as:',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelMedium,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Text(email, textAlign: TextAlign.center),
              ),
              BlocConsumer<HomeBloc, HomeState>(
                listener: (context, state) {
                  if (state is LoggedOut) context.replaceRoute(LoginRoute());
                },
                builder: (context, state) {
                  return ElevatedButton(
                      onPressed: () {
                        context.read<HomeBloc>().add(OnLogoutPressed());
                      },
                      child: state is LoggingOut
                          ? LoadingWidget()
                          : Text('Logout!'));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
