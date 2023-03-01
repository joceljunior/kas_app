import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:kas_app/app/models/crew.dart';

class CrewItemWidget extends StatelessWidget {
  final Crew crew;
  const CrewItemWidget({
    super.key,
    required this.crew,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: Container(
        color: Colors.blue[50]!,
        child: ListTile(
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 1),
            borderRadius: BorderRadius.circular(4),
          ),
          title: Text(
            crew.name.toUpperCase(),
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(crew.key),
          trailing: Icon(Icons.delete),
        ),
      ),
    );
  }
}
