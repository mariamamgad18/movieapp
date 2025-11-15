import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/Api/Api_Manager.dart';
import 'package:movieapp/Ui/login/YellowButton.dart';
import 'package:movieapp/Utils/AppRouteNames.dart';

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
                      // هنا هنستدعي الـ API
                      final response = await ApiManager().login(email: email, password: password);

                      if (response.statusCode == 200) {
                        // مثلا لو السيرفر رجع حاجة فيها success
                        if (response.data['success'] == true) {
                          print("Login Successful");
                          // هنا هننافيجيت للهوم شكرين
                        } else {
                          print("Login Failed: ${response.data['message']}");
                          // هنا ممكن نعرض  AlertDialog و جواه الايرور
                        }
                      } else {
                        print("Error: ${response.statusCode}");
                      }
                    } catch (e) {
                      print("Exception: $e");
                    }
                  } else {
                    print("Validation failed");
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
