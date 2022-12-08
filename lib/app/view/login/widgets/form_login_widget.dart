import 'package:flutter/material.dart';
import 'package:kas_app/core/widgets/button_widget.dart';
import 'package:kas_app/core/widgets/textformfield_widget.dart';

class FormLoginWidget extends StatelessWidget {
  final Size size;
  const FormLoginWidget({
    Key? key,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height * 0.6,
      width: size.width * 0.8,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormFieldWidget(hintText: "Username"),
          TextFormFieldWidget(hintText: "Password"),
          ButtonWidget(
            width: size.width * 0.77,
            height: size.height * 0.08,
            paddingVertical: size.height * 0.08,
            click: () {},
          ),
        ],
      ),
    );
  }
}
