import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget {
  final double height;
  final String userName;
  const AppBarWidget({
    Key? key,
    required this.height,
    required this.userName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(bottom: size.height * 0.12),
      child: Stack(
        children: [
          Container(
            height: height,
            width: size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Theme.of(context).primaryColor,
                  Color.fromARGB(255, 234, 236, 240),
                ],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: size.width * 0.08),
                  child: Text(
                    'Boa noite, $userName',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
