import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final bool? obscureText;
  const TextFormFieldWidget({
    Key? key,
    required this.hintText,
    required this.controller,
    this.keyboardType,
    this.obscureText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.all(size.height * 0.006),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText != null ? obscureText! : false,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          filled: true,
          hintStyle: TextStyle(color: Color.fromARGB(255, 161, 165, 169)),
          hintText: hintText,
          fillColor: Colors.white70,
        ),
      ),
    );
  }
}
