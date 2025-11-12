import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/Utils/AppColors.dart';

import '../../Utils/AppStrings.dart' show AppStrings;

class VerifyButton extends StatelessWidget{
  const VerifyButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Appcolors.yellowColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: const Text(
          AppStrings.verifyEmail,
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
      ),
    );
  }
}