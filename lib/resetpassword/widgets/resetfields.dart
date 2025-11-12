import 'package:flutter/material.dart';
import 'package:movieapp/Utils/AppColors.dart';

class ResetField extends StatelessWidget{
  const ResetField({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildField("Old password"),
        const SizedBox(height: 15),

        _buildField("New password"),
        const SizedBox(height: 15),

        _buildField("Confirm password"),
        const SizedBox(height: 25),

        _buildSaveButton(),
      ],
    );
  }

  Widget _buildField(String hint) {
    return TextField(
      decoration: InputDecoration(
        filled: true,
        fillColor: Appcolors.card,
        hintText: hint,
        hintStyle:  TextStyle(color: Appcolors.grayColor),
        prefixIcon:  Icon(Icons.person, color: Appcolors.grayColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
      style:  TextStyle(color: Appcolors.whitekColor),
    );
  }

  Widget _buildSaveButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Appcolors.yellowColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () {},
        child:  Text(
          "Save",
          style: TextStyle(
            color: Appcolors.blackColor,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}