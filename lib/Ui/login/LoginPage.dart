import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/Ui/login/YellowButton.dart';

import '../../utils/AppColors.dart';
import '../../utils/AppImages.dart';
import 'SwitchLanguageButton.dart';
import 'Textfieldcontainer.dart';

class Loginpage extends StatefulWidget {
  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var Height = MediaQuery.of(context).size.height;
    var Width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Appcolors.blackColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  Appimages.MovieLogo,
                  width: Width * 0.3,
                  height: Height * 0.2,
                ),
              ),
              TextfieldContainer(
                text: "Email",
                prefixIcon: Icons.email,
                controller: emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Email required";
                  }
                  return null;
                },
              ),
              TextfieldContainer(
                text: "Password",
                prefixIcon: Icons.lock,
                controller: passwordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Password required";
                  }
                  return null;
                },
                isPassword: true,
              ),

              InkWell(
                child: Text(
"Forget Password ?"   ,
                  style: TextStyle(
                    color: Appcolors.yellowColor,
                    fontStyle: FontStyle.italic,
                    decoration: TextDecoration.underline,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.end,
                ),
                onTap: () {

                },
              ),
              InkWell(
                onTap: () {
                },
                child: Yellowbutton(
buttonText: "Login",                ),
              ),
              RichText(
                text: TextSpan(
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  children: [
                    TextSpan(
                      text:"Don’t Have Account ?",
                      style: TextStyle(
                          color: Appcolors.whitekColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 14),
                    ),
                    TextSpan(
                      text:"Create One",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,

                        color: Appcolors.yellowColor,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {

                        },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Image.asset(
                  Appimages.OR,
                  width: 270,
                  height: Height * 0.022,
                  fit: BoxFit.fill,
                ),
              ),
Yellowbutton(buttonText:  "Login With Google",imagePath: Appimages.GOOGLE,),
              SizedBox(height: 25),
              Switchlanguagebutton(),
            ],
          ),
        ),
      ),
    );
  }
}
