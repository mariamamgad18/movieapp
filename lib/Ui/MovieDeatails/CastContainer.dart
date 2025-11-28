import 'package:flutter/material.dart';
import 'package:movieapp/Utils/AppColors.dart';

class Castcontainer extends StatelessWidget {
  Castcontainer(
      {super.key, required this.CastImage, required this.CastName, required this.CharacterName });

  String CastImage;
  String CastName;
  String CharacterName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Appcolors.grayColor,
          borderRadius: BorderRadius.circular(16),

        ),
        padding: EdgeInsets.all(11),
        child: Row(
          children: [
            Container(width: 70,
              height: 70,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      image: AssetImage(CastImage), fit: BoxFit.fill)),),
            SizedBox(width: 10,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Name : ",
                        style: TextStyle(
                          color: Appcolors.whitekColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          CastName,
                          style: TextStyle(
                            color: Appcolors.whitekColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 11),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Character : ",
                        style: TextStyle(
                          color: Appcolors.whitekColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          CharacterName,
                          style: TextStyle(
                            color: Appcolors.whitekColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )


          ],
        ),
      ),
    );
  }
}
