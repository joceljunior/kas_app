import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final double width;
  final double height;
  final double paddingVertical;
  final Function click;

  const ButtonWidget({
    Key? key,
    required this.width,
    required this.height,
    required this.paddingVertical,
    required this.click,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: paddingVertical),
      child: SizedBox(
        width: width,
        height: height,
        child: ElevatedButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
          onPressed: () {
            click();
          },
          child: Center(
              child: Text(
            'LOGIN',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 18, letterSpacing: 2),
          )),
        ),
      ),
    );
  }
}
