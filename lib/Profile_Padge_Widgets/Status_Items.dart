import 'package:flutter/material.dart';

class StatusItem extends StatelessWidget {
  final String number;
  final String label;
  final Color numberColor;
  final Color labelColor;
  final double numberFontSize;
  final double labelFontSize;

  const StatusItem({
    super.key,
    required this.number,
    required this.label,
    this.numberColor = Colors.white,
    this.labelColor = Colors.white70,
    this.numberFontSize = 16,
    this.labelFontSize = 14,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(number, style: TextStyle(fontSize: numberFontSize, color: numberColor)),
        Text(label, style: TextStyle(fontSize: labelFontSize, color: labelColor)),
      ],
    );
  }
}
