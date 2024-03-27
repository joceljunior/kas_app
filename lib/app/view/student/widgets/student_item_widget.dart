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
        padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 2.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.blue[50],
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListTile(
            title: Text(
              student.name,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: SizedBox(
              width: MediaQuery.of(context).size.width * 0.4,
              height: MediaQuery.of(context).size.height * 0.007,
              child: Row(
                children: [
                  if (!student.useImage)
                    Icon(
                      Icons.no_photography_outlined,
                      size: 18,
                      color: Colors.redAccent,
                    ),
                  SizedBox(width: 10),
                  if (student.allergy.isNotEmpty && student.allergy != 'Não')
                    Icon(
                      Icons.warning_amber_outlined,
                      size: 18,
                      color: Colors.redAccent[100],
                    ),
                ],
              ),
            ),
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
