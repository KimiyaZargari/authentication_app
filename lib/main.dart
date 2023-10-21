import 'package:authentication_app/injection.dart';
import 'package:authentication_app/presentation/core/config/light_theme.dart';
import 'package:authentication_app/presentation/routes/router.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  configureDependencies();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _appRouter = AppRouter();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _appRouter.config(),
      theme: lightTheme(),
    );
  }
}
