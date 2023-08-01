import 'package:flutter/material.dart';
import 'package:kas_app/core/widgets/background_base_widget.dart';

class CreateSuccessPage extends StatelessWidget {
  const CreateSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: BackgoundBaseWidget(
          size: size.height,
          child: Column(
            children: [
              Image.asset("assets/splash_web.png"),
              Text(
                "Cadastrado com Sucesso!",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
