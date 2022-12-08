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
    return Container(
        height: size,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 236, 159, 186),
              Colors.white,
            ],
          ),
        ),
        child: child);
  }
}
