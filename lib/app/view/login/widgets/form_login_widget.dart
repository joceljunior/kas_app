import 'package:flutter/material.dart';

import 'package:kas_app/core/widgets/textformfield_widget.dart';

class FormLoginWidget extends StatelessWidget {
  final Size size;
  final Widget buttonLogin;
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  const FormLoginWidget({
    Key? key,
    required this.size,
    required this.buttonLogin,
    required this.usernameController,
    required this.passwordController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height * 0.6,
      width: size.width * 0.8,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormFieldWidget(
              hintText: "Username", controller: usernameController),
          TextFormFieldWidget(
              hintText: "Password",
              controller: passwordController,
              keyboardType: TextInputType.visiblePassword,
              obscureText: true),
          buttonLogin
        ],
      ),
    );
  }
}
