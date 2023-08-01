import 'package:flutter/material.dart';

class TotalWidget extends StatelessWidget {
  final Size size;
  final String crewTotal;
  final String studentTotal;
  const TotalWidget({
    Key? key,
    required this.size,
    required this.crewTotal,
    required this.studentTotal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(size.height * 0.003),
      child: Container(
        padding: EdgeInsets.all(size.height * 0.02),
        height: size.height * 0.1,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.pink[50]!,
              Color(0xFFF0B3C8),
            ],
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(
                  "Total Turmas",
                  style: TextStyle(fontSize: 12),
                ),
                Text(
                  crewTotal,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  "Total Alunos",
                  style: TextStyle(fontSize: 12),
                ),
                Text(
                  studentTotal,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
