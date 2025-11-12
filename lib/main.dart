import 'package:flutter/material.dart';
import 'package:movieapp/forgetpassword/forgetpassword_screen.dart';
import 'package:movieapp/register/register_screen.dart';
import 'package:movieapp/update/profile_screen.dart';
import 'Ui/login/LoginPage.dart';
import 'Ui/onboarding_screen.dart';
import 'Utils/AppRouteNames.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movies App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      initialRoute: Approutenames.OnBoardingScreen,
      routes: {
        Approutenames.OnBoardingScreen: (context) => OnboardingScreens(),
        Approutenames.Login: (context) => Loginpage(),
        Approutenames.Register: (context) => RegisterScreen(),
        Approutenames.profile: (context) => ProfileScreen(),
        Approutenames.ForgetPassword:(context)=>ForgetPasswordScreen(),

      },
    );
  }
}

