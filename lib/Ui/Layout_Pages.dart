import 'package:flutter/material.dart';

import '../Pages/Browse_Page.dart';
import '../Pages/Profile_Page.dart';
import '../Pages/Search_Page.dart';
import '../Pages/tabs/home_tab.dart';
import 'bottom_navigation_bar.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({super.key});

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  int currentIndex = 0;

  final List<Widget> pages =  [
    HomeTab(),
    SearchPage(),
    BrowsePage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: pages[currentIndex],

      bottomNavigationBar: CustomBottomNav(
        currentIndex: currentIndex,
        onTap: (i) {
          setState(() {
            currentIndex = i;
          });
        },
      ),
    );
  }
}
