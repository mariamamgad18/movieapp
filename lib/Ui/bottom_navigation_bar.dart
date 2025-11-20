import 'package:flutter/material.dart';
import 'package:movieapp/Utils/AppColors.dart';


class CustomBottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:  EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration:  BoxDecoration(
        color: Appcolors.blackColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _item(icon: Icons.home_filled, index: 0),
          _item(icon: Icons.search, index: 1),
          _item(icon: Icons.explore, index: 2),
          _item(icon: Icons.person, index: 3),
        ],
      ),
    );
  }

  Widget _item({required IconData icon, required int index}) {
    final bool selected = currentIndex == index;

    return GestureDetector(
      onTap: () => onTap(index),
      child: Icon(
        icon,
        size: 30,
        color: selected ? Appcolors.yellowColor : Appcolors.whitekColor,
      ),
    );
  }
}
