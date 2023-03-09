import 'package:flutter/material.dart';
import 'package:kas_app/app/models/student.dart';

class StudentItemWidget extends StatelessWidget {
  final Student student;
  final Function onTapEdit;
  final Function onTapDelete;
  const StudentItemWidget({
    super.key,
    required this.student,
    required this.onTapEdit,
    required this.onTapDelete,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTapEdit();
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
              student.name,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text("Turma: ${student.crew.name}"),
            trailing: GestureDetector(
              onTap: () {
                onTapDelete();
              },
              child: Icon(
                Icons.delete,
                color: Color.fromARGB(255, 246, 185, 207),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
