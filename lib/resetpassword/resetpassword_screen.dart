import 'package:flutter/material.dart';
import 'package:movieapp/Utils/AppColors.dart';
import 'package:movieapp/resetpassword/widgets/resetfields.dart';
import 'package:movieapp/resetpassword/widgets/resetimage.dart';
import 'package:movieapp/update/profile_screen.dart';

class ResetPasswordScreen extends StatelessWidget{
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors.blackColor,

      appBar: AppBar(
        backgroundColor: Appcolors.blackColor,
        elevation: 0,
        leading: IconButton(
          icon:  Icon(Icons.arrow_back, color: Appcolors.yellowColor),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => ProfileScreen()),
                  (route) => false,
            );
          },
        ),
        title: Text(
          "Change Password",
          style: TextStyle(color: Appcolors.yellowColor),
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ResetImage(),
              SizedBox(height: 25),
              ResetField(),
            ],
          ),
        ),
      ),
    );
  }
}