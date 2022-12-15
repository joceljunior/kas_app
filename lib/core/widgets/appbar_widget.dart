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
              Colors.blue[400]!,
              Color.fromARGB(255, 206, 214, 228),
            ],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(size.height * 0.01),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.notification_important_outlined,
                      size: size.height * 0.05,
                    ),
                    Icon(
                      Icons.settings,
                      size: size.height * 0.05,
                    ),
                  ],
                ),
              ),
              Image.asset(
                logoSplash,
                height: size.height * 0.2,
              ),
              Text(
                userName,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.2,
                    vertical: size.height * 0.002),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('30 Turmas'),
                    Text('206 Alunos'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
