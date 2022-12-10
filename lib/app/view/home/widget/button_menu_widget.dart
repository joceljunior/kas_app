import 'package:flutter/material.dart';

class ButtonMenuWidget extends StatelessWidget {
  const ButtonMenuWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue[200]!),
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      height: 130,
      width: 140,
    );
  }
}
