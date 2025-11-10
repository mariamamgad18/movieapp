import 'package:flutter/material.dart';

import 'Ui/login/LoginPage.dart';
import 'Ui/onboarding_screen.dart';
import 'Utils/AppRouteNames.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        initialRoute: Approutenames.OnBoardingScreen,
        routes: {
          Approutenames.OnBoardingScreen: (context) => OnboardingScreens(),
          Approutenames.Login: (context) => Loginpage(),

        }
    );

  }


}
