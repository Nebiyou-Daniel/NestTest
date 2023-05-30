import 'package:flutter/material.dart';

class InitialsAvatar extends StatelessWidget {
  final String initials;

  const InitialsAvatar({
    super.key,
    required this.initials,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 50,
      child: Text(
        initials.split(" ").length == 2
            ? initials.split(" ")[0][0] + initials.split(" ")[1][0]
            : initials.split(" ")[0][0],
        style: const TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
