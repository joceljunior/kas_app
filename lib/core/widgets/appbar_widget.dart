import 'package:flutter/material.dart';

import '../constants/assets.dart';

class AppBarWidget extends StatelessWidget {
  final String userName;
  const AppBarWidget({
    Key? key,
    required this.userName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(bottom: size.height * 0.10),
      child: Container(
        height: size.height * 0.40,
        width: size.width,
        decoration: BoxDecoration(
          // borderRadius: BorderRadius.only(
          //   bottomLeft: Radius.circular(30),
          //   bottomRight: Radius.circular(30),
          // ),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).primaryColor,
              Colors.white,
            ],
          ),
        ),
      ),
    );
  }
}
