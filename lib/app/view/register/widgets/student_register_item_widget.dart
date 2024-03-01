import 'package:flutter/material.dart';

import 'package:kas_app/app/models/student.dart';

class StudentRegisterItemWidget extends StatelessWidget {
  final Student student;
  final Function(bool value) ontapParticipation;
  final Function ontapJustification;
  const StudentRegisterItemWidget({
    Key? key,
    required this.student,
    required this.ontapParticipation,
    required this.ontapJustification,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: Container(
        color: student.isRegister
            ? Colors.blue[200]!
            : Color.fromARGB(255, 232, 230, 230),
        child: ListTile(
          onTap: () {
            ontapJustification();
          },
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 1),
            borderRadius: BorderRadius.circular(4),
          ),
          title: Text(
            student.name,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          trailing: SizedBox(
            width: MediaQuery.of(context).size.width * 0.2,
            height: MediaQuery.of(context).size.height,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                student.justification != null
                    ? Icon(Icons.notification_important_sharp)
                    : Container(),
                Checkbox(
                  onChanged: (bool? value) {
                    ontapParticipation(value!);
                  },
                  value: student.isRegister,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
