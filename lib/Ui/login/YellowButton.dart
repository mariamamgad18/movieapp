import 'package:flutter/material.dart';
import 'package:movieapp/Utils/AppColors.dart';

class Yellowbutton extends StatelessWidget {
  final String buttonText;
  final String? imagePath; // الصورة اختيارية

  Yellowbutton({
    required this.buttonText,
    this.imagePath, // مش required
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 392,
      height: 56,
      decoration: BoxDecoration(
        color: Appcolors.yellowColor,
        borderRadius: BorderRadius.circular(15),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (imagePath != null) ...[
            Image.asset(
              imagePath!,
              width: 28,
              height: 28,
            ),
            SizedBox(width: 8),
          ],
          Text(
            buttonText,
            style: TextStyle(
              color: Appcolors.blackColor,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
