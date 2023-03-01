// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';

class ButtonMenuWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function ontap;
  const ButtonMenuWidget(
      {super.key,
      required this.icon,
      required this.title,
      required this.ontap});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => ontap(),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blue[200]!),
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        height: 130,
        width: 140,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Icon(
                icon,
                size: 50,
                color: Colors.blue[400]!,
              ),
            ),
            Text(
              title.toUpperCase(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
