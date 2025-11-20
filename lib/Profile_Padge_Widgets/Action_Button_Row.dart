import 'package:flutter/material.dart';
import 'Action_Button.dart';

class ActionButtonsRow extends StatelessWidget {
  const ActionButtonsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ActionButton(
            label: "Edit Profile",
            icon: Icons.edit,
            color: Colors.yellow,
            textColor: Colors.black,
            onTap: () {},
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ActionButton(
            label: "Exit",
            icon: Icons.logout,
            color: Colors.red,
            textColor: Colors.white,
            onTap: () {},
          ),
        ),
      ],
    );
  }
}
