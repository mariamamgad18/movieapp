import 'package:flutter/material.dart';
import 'package:movieapp/Utils/AppColors.dart';
import 'package:movieapp/forgetpassword/widget/email_field.dart';
import 'package:movieapp/forgetpassword/widget/forget_image.dart';
import 'package:movieapp/forgetpassword/widget/verify_button.dart';

import '../Utils/AppStrings.dart';

class ForgetPasswordScreen extends StatelessWidget{
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors.blackColor,
      appBar: _buildAppBar(context),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: const [
            ForgetImage(),
            SizedBox(height: 20),
            EmailField(),
            SizedBox(height: 30),
            VerifyButton(),
          ],
        ),
      ),
    );
  }
  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Appcolors.blackColor,
      elevation: 0,
      leading: IconButton(
        icon:  Icon(Icons.arrow_back, color: Appcolors.yellowColor),
        onPressed: () => Navigator.pop(context),
      ),
      title:  Text(
        AppStrings.title,
        style: TextStyle(color: Appcolors.yellowColor),
      ),
      centerTitle: true,
    );
  }
}