import 'package:flutter/material.dart';
import 'package:movieapp/Utils/AppColors.dart';

class Genereitem extends StatelessWidget {
   Genereitem({super.key,required this.Genere});
String Genere;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8,horizontal: 38),
      decoration: BoxDecoration(color: Appcolors.grayColor,
      borderRadius: BorderRadius.circular(12))
      ,
      child: Text(Genere,style: TextStyle(color: Appcolors.whitekColor,fontSize: 16,fontWeight: FontWeight.w400),),

    );
  }
}
