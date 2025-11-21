import 'package:flutter/material.dart';

import 'Status_Items.dart';


class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: const [
            CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage("assets/images/gamer.png"),
            ),
            SizedBox(height: 10),
            Text(
              "John Safwat",
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),

        const Spacer(),

        Padding(
          padding: const EdgeInsets.only(top: 25),
          child: Row(
            children: const [
              StatusItem(
                number: "   12",
                label: "Wish List",
                numberColor: Colors.white,
                labelColor: Colors.white,
                numberFontSize: 36,
                labelFontSize: 24,
              ),
              SizedBox(width: 40),
              StatusItem(
                number: "  10",
                label: "History",
                numberColor: Colors.white,
                labelColor: Colors.white,
                numberFontSize: 36,
                labelFontSize: 24,
              ),
            ],
          ),
        ),

        const Spacer(),
      ],
    );
  }
}
