import 'package:flutter/material.dart';

import '../../Utils/AppColors.dart';

class Trasparentbutton extends StatelessWidget {
  final String buttonText;
  Trasparentbutton({
    required this.buttonText
});
  @override
  Widget build(BuildContext context) {
      return Container(
      width: 392,
      height: 56,
      decoration: BoxDecoration(
        color: Appcolors.transparentColor,
        border: Border.all(
          color: Appcolors.yellowColor,

        ),
        borderRadius: BorderRadius.circular(15),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Text(
            buttonText,
            style: TextStyle(
              color: Appcolors.yellowColor,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
