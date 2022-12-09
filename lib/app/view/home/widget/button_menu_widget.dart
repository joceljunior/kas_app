import 'package:flutter/material.dart';

class ButtonMenuWidget extends StatelessWidget {
  const ButtonMenuWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromARGB(255, 170, 165, 165)),
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      height: 100,
      width: 110,
    );
  }
}
