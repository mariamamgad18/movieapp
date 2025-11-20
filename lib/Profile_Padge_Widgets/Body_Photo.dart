import 'package:flutter/material.dart';

class CenteredPhoto extends StatelessWidget {
  const CenteredPhoto({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
       'assets/images/search_tab.png',
        width: 120,
        height: 120,
        fit: BoxFit.cover,
      ),
    );
  }
}
