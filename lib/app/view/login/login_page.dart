import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:kas_app/app/view/login/widgets/form_login_widget.dart';
import 'package:kas_app/core/widgets/background_base_widget.dart';
import 'package:kas_app/core/widgets/textformfield_widget.dart';

import '../../../core/constants/assets.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
                child: FormLoginWidget(size: size),
              ),
            ],
          ),
          size: size.height,
        ),
      ),
    );
  }
}
