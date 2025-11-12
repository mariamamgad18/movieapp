import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/Utils/AppColors.dart';
import 'package:movieapp/Utils/AppStrings.dart';

class EmailField extends StatelessWidget{
  const EmailField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        filled: true,
        fillColor: Appcolors.card,
        prefixIcon:  Icon(Icons.email, color: Appcolors.grayColor),
        hintText: AppStrings.emailHint,
        hintStyle: TextStyle(color: Appcolors.grayColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
      style: const TextStyle(color: Colors.white),
    );
  }
}