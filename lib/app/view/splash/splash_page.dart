import 'package:flutter/material.dart';

import '../../../core/constants/assets.dart';
import '../../../core/constants/routes.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    changeOpacity();
    navigation();
  }

  double opacityLevel = 0;

  Future<void> changeOpacity() async {
    await Future.delayed(
      Duration(seconds: 1),
      (() {
        setState(() => opacityLevel = opacityLevel == 0 ? 1.0 : 0.0);
      }),
    );
  }

  Future<void> navigation() async {
    await Future.delayed(
      Duration(seconds: 3),
      (() {
        Navigator.of(context)
            .pushNamedAndRemoveUntil(loginPage, (route) => false);
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      color: Color.fromARGB(255, 246, 185, 207),
      child: Center(
        child: AnimatedOpacity(
          duration: Duration(seconds: 2),
          opacity: opacityLevel,
          child: Image.asset(
            logoSplash,
            height: size.height * 0.3,
          ),
        ),
      ),
      height: size.height,
    );
  }
}
