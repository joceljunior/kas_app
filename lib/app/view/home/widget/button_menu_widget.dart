// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';

class ButtonMenuWidget extends StatelessWidget {
  final String image;
  final String title;
  final Function ontap;
  const ButtonMenuWidget(
      {super.key,
      required this.image,
      required this.title,
      required this.ontap});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => ontap(),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        height: size.height * 0.25,
        width: size.width * 0.4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Opacity(opacity: 0.6, child: Image.asset(image)),
            ),
            Text(
              title.toUpperCase(),
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 93, 124, 150)),
            ),
          ],
        ),
      ),
    );
  }
}
