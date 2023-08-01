import 'package:flutter/material.dart';

class BackgoundBaseWidget extends StatelessWidget {
  final Widget child;
  final double size;
  const BackgoundBaseWidget({
    Key? key,
    required this.child,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(color: Color(0xFFF5F4FC), height: size, child: child);
  }
}
