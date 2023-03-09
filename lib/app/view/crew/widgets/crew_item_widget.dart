import 'package:flutter/material.dart';
import 'package:kas_app/core/constants/routes.dart';
import '../../../models/crew.dart';

class CrewItemWidget extends StatelessWidget {
  final Crew crew;
  final Function onTapEdit;
  const CrewItemWidget({
    super.key,
    required this.crew,
    required this.onTapEdit,
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
          trailing: GestureDetector(child: Icon(Icons.edit)),
          onTap: () => onTapEdit(),
        ),
      ),
    );
  }
}
