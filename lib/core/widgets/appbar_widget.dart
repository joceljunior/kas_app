import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget {
  final double height;
  const AppBarWidget({
    Key? key,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(bottom: size.height * 0.05),
      child: Stack(
        children: [
          Container(
            height: height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(70),
                bottomRight: Radius.circular(70),
              ),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomLeft,
                colors: [
                  Color.fromARGB(255, 113, 123, 235),
                  Color.fromARGB(255, 234, 236, 240),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
