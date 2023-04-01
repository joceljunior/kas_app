import 'package:flutter/material.dart';
import '../../../models/crew.dart';

class CrewItemWidget extends StatelessWidget {
  final Crew crew;
  final bool showTrailing;
  final Function onTapEditItem;
  final Function onTapItem;
  const CrewItemWidget({
    super.key,
    required this.crew,
    required this.onTapEditItem,
    required this.onTapItem,
    required this.showTrailing,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTapItem(),
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
              crew.name.toUpperCase(),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(crew.key),
            trailing: showTrailing
                ? GestureDetector(
                    onTap: () => onTapEditItem(),
                    child: Icon(Icons.mode_edit_outline_rounded))
                : null,
          ),
        ),
      ),
    );
  }
}
