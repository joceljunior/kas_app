import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFormFieldWidget extends StatelessWidget {
  final int? maxLines;
  final String hintText;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final bool? obscureText;
  final String? Function(String value)? validator;
  final Function(String value)? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  const TextFormFieldWidget({
    Key? key,
    this.maxLines,
    required this.hintText,
    required this.controller,
    this.keyboardType,
    this.obscureText,
    required this.validator,
    this.onChanged,
    this.inputFormatters,
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
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          labelStyle: TextStyle(color: Colors.black54),
          labelText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          filled: true,
          hintStyle: TextStyle(color: Color.fromARGB(255, 161, 165, 169)),
          // hintText: hintText,
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          fillColor: Colors.white70,
        ),
        validator: validator as String? Function(String?),
        onChanged: onChanged,
      ),
    );
  }
}
