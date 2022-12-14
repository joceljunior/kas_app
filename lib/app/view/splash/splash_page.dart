import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:kas_app/core/constants/assets.dart';
import 'package:kas_app/core/constants/routes.dart';
import 'package:kas_app/core/routes/interfaces/i_kas_router.dart';
import 'package:kas_app/core/widgets/background_base_widget.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

IKasRouter router = GetIt.I<IKasRouter>();

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
        router.navigation(context: context, screen: loginPage);
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BackgoundBaseWidget(
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
      size: size.height,
    );
  }
}
