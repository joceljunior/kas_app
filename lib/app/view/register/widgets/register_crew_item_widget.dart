import 'package:flutter/material.dart';
import 'package:kas_app/app/models/register.dart';

class RegisterCrewItemWidget extends StatelessWidget {
  final Register register;
  final Function ontapEdit;
  const RegisterCrewItemWidget({
    Key? key,
    required this.register,
    required this.ontapEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ontapEdit();
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 5.0),
        child: Container(
          color: Colors.blue[50]!,
          child: ListTile(
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 1),
              borderRadius: BorderRadius.circular(4),
            ),
            title: Text(
              "${register.dateRegister.day}/${register.dateRegister.month}/${register.dateRegister.year}",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            trailing: Text(checkPresence()),
          ),
        ),
      ),
    );
  }

  String checkPresence() {
    var presence = register.studentRegisters
        .where((element) => element.participation == true)
        .length;

    return "$presence presenças";
  }
}
