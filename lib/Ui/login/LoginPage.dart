import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/Api/Api_Manager.dart';
import 'package:movieapp/Ui/login/YellowButton.dart';
import 'package:movieapp/Utils/AppRouteNames.dart';

import '../../Utils/UserToken.dart';
import '../../utils/AppColors.dart';
import '../../utils/AppImages.dart';
import 'ShowDialog.dart';
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
  void dispose(){
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
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

              /// Logo
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  Appimages.MovieLogo,
                  width: Width * 0.3,
                  height: Height * 0.2,
                ),
              ),

              /// Email field
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

              /// Password field
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

              /// Forget password
              InkWell(
                child: Text(
                  "Forget Password ?",
                  style: TextStyle(
                    color: Appcolors.yellowColor,
                    fontStyle: FontStyle.italic,
                    decoration: TextDecoration.underline,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.end,
                ),
                onTap: () {},
              ),

              /// Login button
              InkWell(
                onTap: () async {
                  if (formKey.currentState!.validate()) {
                    final String email = emailController.text.trim();
                    final String password = passwordController.text.trim();

                    try {
                      final response = await ApiManager().login(email: email, password: password);

                      if (response.statusCode == 200 || response.statusCode == 201) {

                        if ((response.data['message'] as String).contains("Success")) {
                          String token = response.data['token'];
                          await Usertoken.saveToken(token);  // يعني خد التوكين احفظه ف الشيرد بريفرنس
                          print("Token saved: $token");
                          MyDialog.show(context: context, title: "Done", message: "Login Successful", onPressed: () {
                            Navigator.of(context).pushReplacementNamed(Approutenames.profile);

                          });
                        } else {
                          print("Login Failed: ${response.data['message']}");
                          MyDialog.show(context: context, title: "Login Failed", message: "${response.data['message']}", onPressed: () {

                            Navigator.of(context).pop();

                          });

                        }
                      } else {
                        print("Error: ${response.statusCode}");
                        MyDialog.show(context: context, title: "Error!", message: " ${response.statusCode}", onPressed: () {
                          Navigator.of(context).pop();

                        });

                      }
                    } catch (e) {
                      print("Exception: $e");
                      MyDialog.show(context: context, title: "Exception!", message: "$e", onPressed: () {
                        Navigator.of(context).pop();

                      });

                    }
                  } else {
                    print("Validation failed");
                    MyDialog.show(context: context, title: "Exception!", message: "Validation failed", onPressed: () {
                      Navigator.of(context).pop();

                    });

                  }
                },
                child: Yellowbutton(
                  buttonText: "Login",
                ),
              ),


              /// Register text
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  children: [
                    TextSpan(
                      text: "Don’t Have Account ? ",
                      style: TextStyle(
                        color: Appcolors.whitekColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                    TextSpan(
                      text: "Create One",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Appcolors.yellowColor,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {

                        Navigator.of(context).pushReplacementNamed(Approutenames.Register);
                        },
                    ),
                  ],
                ),
              ),

              /// OR image
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Image.asset(
                  Appimages.OR,
                  width: 270,
                  height: Height * 0.022,
                  fit: BoxFit.fill,
                ),
              ),

              /// Google login button
              Yellowbutton(
                buttonText: "Login With Google",
                imagePath: Appimages.GOOGLE,
              ),

              SizedBox(height: 25),

              /// Language switch
              Switchlanguagebutton(),
            ],
          ),
        ),
      ),
    );
  }
}
