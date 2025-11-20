import 'package:flutter/material.dart';

class TabItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool active;

  const TabItem({
    super.key,
    required this.icon,
    required this.label,
    this.active = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = active ? Colors.yellow : Colors.grey;
    return Column(
      children: [
        Icon(icon, color: color),
        const SizedBox(height: 5),
        Text(
          label,
          style: TextStyle(color: color, fontWeight: active ? FontWeight.bold : FontWeight.normal),
        ),
      ],
    );
  }
}
