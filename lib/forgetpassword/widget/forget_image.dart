import 'package:flutter/cupertino.dart';
import 'package:movieapp/Utils/AppImages.dart';

class ForgetImage extends StatelessWidget{
  const ForgetImage({super.key});

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