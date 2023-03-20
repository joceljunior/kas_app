import 'package:flutter/material.dart';
import 'package:kas_app/app/models/register_crew.dart';

class RegisterCrewItemWidget extends StatelessWidget {
  final RegisterCrew register;
  const RegisterCrewItemWidget({
    Key? key,
    required this.register,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: Container(
        color: Colors.blue[100]!,
        child: ListTile(
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 1),
            borderRadius: BorderRadius.circular(4),
          ),
          title: Text(
            "${register.date.day}/${register.date.month}/${register.date.year}",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          trailing: Text(checkPresence()),
        ),
      ),
    );
  }

  String checkPresence() {
    var presence = register.registers
        .where((element) => element.participation == true)
        .length;

    return "$presence presenças";
  }
}
