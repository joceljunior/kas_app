import 'package:flutter/material.dart';

import '../../../core/constants/assets.dart';
import '../../../core/widgets/background_base_widget.dart';
import '../../../core/widgets/button_widget.dart';
import 'widgets/form_login_widget.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: BackgoundBaseWidget(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                logoSplash,
                height: size.height * 0.3,
              ),
              Center(
                child: FormLoginWidget(
                  passwordController: passwordController,
                  usernameController: usernameController,
                  size: size,
                  buttonLogin: ButtonWidget(
                    width: size.width * 0.77,
                    height: size.height * 0.08,
                    paddingVertical: size.height * 0.08,
                    click: () {},
                  ),
                ),
              ),
            ],
          ),
          size: size.height,
        ),
      ),
    );
  }
}
