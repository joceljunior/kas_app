import 'package:flutter/material.dart';
import 'package:kas_app/app/view/login/login_page.dart';
import 'package:kas_app/app/view/splash/splash_page.dart';
import 'package:kas_app/core/constants/routes.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kas Ballet',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashPage(),
      routes: {
        loginPage: (_) => LoginPage(),
      },
    );
  }
}
