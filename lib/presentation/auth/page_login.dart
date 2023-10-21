import 'package:authentication_app/application/auth/login_bloc.dart';
import 'package:authentication_app/injection.dart';
import 'package:authentication_app/presentation/routes/router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../core/config/strings.dart';
import '../core/config/vectors.dart';
import '../core/widgets/loading_widget.dart';
import '../core/widgets/page_base.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/widgets/text_field.dart';

@RoutePage()
class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return BlocProvider(
      create: (_) => getIt<LoginBloc>(),
      child: BlocConsumer<LoginBloc, LoginState>(listener: (context, state) {
        state.authFailureOrSuccess?.fold(
          (failure) {
            failure.maybeMap(
              orElse: () {},
              serverError: (_) {
                Fluttertoast.showToast(msg: _.message);
              },
            );
          },
          (email) {
            context.router.replace(HomeRoute(email: email));
          },
        );
      }, builder: (context, state) {
        return PageBase(
            title:
                state.isNewUser ? AppStrings.createAccount : AppStrings.login,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                  autovalidateMode: state.showValidationMessages
                      ? AutovalidateMode.always
                      : AutovalidateMode.disabled,
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      AppTextField(
                        label: 'Email Address',
                        textInputType: TextInputType.emailAddress,
                        onChanged: (val) => context
                            .read<LoginBloc>()
                            .add(LoginEvent.emailChanged(val)),
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return 'Please enter your email address!';
                          }
                          const emailRegex =
                              r"""^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+""";
                          if (!RegExp(emailRegex).hasMatch(val)) {
                            return AppStrings.invalidEmailError;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      AppTextField(
                        label: 'Password',
                        isPassword: true,
                        onChanged: (val) => context
                            .read<LoginBloc>()
                            .add(LoginEvent.passwordChanged(val)),
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return 'Please enter your password!';
                          } else if (val.length < 8) {
                            return AppStrings.invalidPasswordError;
                          }
                          return null;
                        },
                      ),
                      if (state.authFailureOrSuccess != null)
                        state.authFailureOrSuccess!.fold(
                            (l) => l.maybeMap(
                                cancelledByUser: (_) => Container(),
                                serverError: (_) => Container(),
                                orElse: () => Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          6, 20, 6, 0),
                                      child: Text(
                                        l.message,
                                        style: Theme.of(context)
                                            .textTheme
                                            .displaySmall!
                                            .copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .error),
                                      ),
                                    )),
                            (r) => Container()),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 30.0),
                        child: ElevatedButton(
                          onPressed: () {
                            if (!state.isSubmitting &&
                                !state.waitingForGoogle) {
                              if (formKey.currentState!.validate()) {
                                if (state.isNewUser) {
                                  context.read<LoginBloc>().add(LoginEvent
                                      .registerWithEmailAndPasswordPressed());
                                } else {
                                  context.read<LoginBloc>().add(LoginEvent
                                      .signInWithEmailAndPasswordPressed());
                                }
                              } else if (state.showValidationMessages ==
                                  false) {
                                context
                                    .read<LoginBloc>()
                                    .add(LoginEvent.startAutoValidate());
                              }
                            }
                          },
                          child: state.isSubmitting
                              ? LoadingWidget(
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                )
                              : Text(state.isNewUser
                                  ? AppStrings.createAccount
                                  : AppStrings.login),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(state.isNewUser
                              ? 'Already have an account?'
                              : 'Don\'t have an account?'),
                          TextButton(
                              onPressed:
                                  !state.isSubmitting && !state.waitingForGoogle
                                      ? () {
                                          context
                                              .read<LoginBloc>()
                                              .add(LoginEvent.switchUserType());
                                        }
                                      : null,
                              child: Text(state.isNewUser
                                  ? AppStrings.login
                                  : 'Register'))
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 40.0),
                        child: Row(
                          children: [
                            Expanded(child: Divider(thickness: 2)),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text('or'),
                            ),
                            Expanded(child: Divider(thickness: 2))
                          ],
                        ),
                      ),
                      FilledButton(
                        style: FilledButton.styleFrom(
                            backgroundColor: Theme.of(context).cardColor,
                            foregroundColor:
                                Theme.of(context).textTheme.bodyMedium!.color,
                            elevation: 6),
                        onPressed: () {
                          if (!state.isSubmitting && !state.waitingForGoogle) {
                            context
                                .read<LoginBloc>()
                                .add(LoginEvent.signInWithGooglePressed());
                          }
                        },
                        child: state.waitingForGoogle
                            ? const LoadingWidget()
                            : Row(
                                children: [
                                  SvgPicture.asset(
                                    AppVectors.google,
                                    height: 20,
                                  ),
                                  const Expanded(
                                      child: Text(
                                    'Login with with Google',
                                    textAlign: TextAlign.center,
                                  ))
                                ],
                              ),
                      ),
                    ],
                  )),
            ));
      }),
    );
  }
}
