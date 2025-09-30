import 'package:flutter/material.dart';

class SimpleAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  final List<Widget>? actions;

  const SimpleAppBarWidget({
    Key? key,
    required this.title,
    this.showBackButton = true,
    this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(color: Colors.black),
      ),
      backgroundColor: const Color.fromARGB(255, 246, 185, 207),
      foregroundColor: Colors.black,
      automaticallyImplyLeading: showBackButton,
      actions: actions,
      elevation: 5,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
