import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  final int? maxLines;
  final String hintText;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final bool? obscureText;
  final String? Function(String value)? validator;
  const TextFormFieldWidget({
    Key? key,
    this.maxLines,
    required this.hintText,
    required this.controller,
    this.keyboardType,
    this.obscureText,
    required this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(bottom: size.height * 0.006),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
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
        validator: validator as String? Function(String?),
      ),
    );
  }
}
