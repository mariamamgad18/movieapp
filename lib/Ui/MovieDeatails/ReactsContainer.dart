import 'package:flutter/cupertino.dart';
import 'package:movieapp/utils/AppColors.dart';

class Reactscontainer extends StatelessWidget {
String iconName;
double NumerOfreacts;
  Reactscontainer({
    required this.iconName,
    required this.NumerOfreacts

  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
       decoration: BoxDecoration(
         borderRadius: BorderRadius.circular(16),
         color: Appcolors.grayColor,

       ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 11,horizontal: 11),
          child: Row(
            children: [
              Image(image: AssetImage(iconName)),
              SizedBox(width: 8,),
              Text(NumerOfreacts.toString(),style:TextStyle(
                color: Appcolors.whitekColor,
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ) ,)

            ],
          ),
        ),
      ),
    );
  }
}
