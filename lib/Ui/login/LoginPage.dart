import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/Ui/login/YellowButton.dart';
import 'package:movieapp/Utils/AppRouteNames.dart';

import '../../Cubit/LoginCubit/LoginStates.dart';
import '../../Cubit/LoginCubit/Login_View_Model.dart';
import '../../Utils/google_signin_helper.dart';
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
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return BlocProvider(
      create: (_) => LoginViewModel(),
      child: Builder(
        builder: (context) {
          return BlocListener<LoginViewModel, Loginstates>(
            listener: (context, state) {
              if (state is LoginLoadingState) {
                MyDialog.show(
                    context: context,
                    title: "Loading",
                    message: "Please wait...",
                    onPressed: () {});
              } else if (state is LoginSuccessState) {
                Navigator.pop(context);
                MyDialog.show(
                  context: context,
                  title: "Done",
                  message: state.SuccessMessage ?? "Login Successful",
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                        context, Approutenames.LayoutScreens);
                  },
                );
              } else if (state is LoginErrorState) {
                Navigator.pop(context);
                MyDialog.show(
                  context: context,
                  title: "Error!",
                  message: state.ErrorMessage ?? "Something went wrong",
                  onPressed: () {
                    Navigator.pop(context);
                  },
                );
              }
            },
            child: Scaffold(
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
                          width: width * 0.3,
                          height: height * 0.2,
                        ),
                      ),

                      /// Email
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

                      /// Password
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
                        ),
                        onTap: () {},
                      ),

                      /// Login Button
                      InkWell(
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            context.read<LoginViewModel>().Login(
                                emailController.text.trim(),
                                passwordController.text.trim());
                          }
                        },
                        child: Yellowbutton(buttonText: "Login"),
                      ),

                      /// Register text
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                          children: [
                            TextSpan(
                              text: "Don’t Have Account ? ",
                              style: TextStyle(
                                color: Appcolors.whitekColor,
                                fontSize: 14,
                              ),
                            ),
                            TextSpan(
                              text: "Create One",
                              style: TextStyle(
                                color: Appcolors.yellowColor,
                                fontWeight: FontWeight.bold,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.of(context).pushReplacementNamed(
                                      Approutenames.Register);
                                },
                            ),
                          ],
                        ),
                      ),

                      /// OR
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Image.asset(
                          Appimages.OR,
                          width: 270,
                          height: height * 0.022,
                          fit: BoxFit.fill,
                        ),
                      ),

                      /// Google login
                      InkWell(
                        onTap: () async {
                          final user = await GoogleSignInHelper.signIn();
                          if (user != null) {
                            MyDialog.show(
                              context: context,
                              title: "Success",
                              message: "Logged in as ${user.displayName}",
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                    context, Approutenames.LayoutScreens);
                              },
                            );
                          } else {
                            MyDialog.show(
                              context: context,
                              title: "Failed",
                              message: "Google Sign-In failed or cancelled",
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            );
                          }
                        },
                        child: Yellowbutton(
                          buttonText: "Login With Google",
                          imagePath: Appimages.GOOGLE,
                        ),
                      ),

                      const SizedBox(height: 25),

                      /// Switch language
                      Switchlanguagebutton(),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
