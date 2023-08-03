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
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: SizedBox(
        height: size.height * 0.4,
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormFieldWidget(
              hintText: "Username",
              controller: usernameController,
              maxLines: 1,
              validator: (String? value) {
                return value;
              },
            ),
            TextFormFieldWidget(
              hintText: "Password",
              controller: passwordController,
              keyboardType: TextInputType.visiblePassword,
              maxLines: 1,
              obscureText: true,
              validator: (String? value) {
                return value;
              },
            ),
            SizedBox(
              height: size.height * 0.04,
            ),
            buttonLogin
          ],
        ),
      ),
    );
  }
}
