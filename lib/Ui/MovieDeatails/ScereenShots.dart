import 'package:flutter/material.dart';

class Scereenshots extends StatelessWidget {
  final String ScreenShotsImage;

  Scereenshots({super.key, required this.ScreenShotsImage});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 13.0),
      child: Container(
        height: 167,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: NetworkImage(ScreenShotsImage), // <-- هنا
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
