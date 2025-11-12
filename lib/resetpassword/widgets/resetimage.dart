import 'package:flutter/cupertino.dart';
import 'package:movieapp/utils/AppImages.dart';

class ResetImage extends StatelessWidget{
  const ResetImage({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 230,
      child: Image.asset(
        Appimages.ForgotPassword,
        fit: BoxFit.contain,
      ),
    );
  }
}