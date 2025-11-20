import 'package:flutter/material.dart';

class TabsSection extends StatefulWidget {
  const TabsSection({super.key});

  @override
  State<TabsSection> createState() => _TabsSectionState();
}

class _TabsSectionState extends State<TabsSection> {
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => setState(() => activeIndex = 0),
                child: Column(
                  children: [
                    Icon(Icons.list, color: activeIndex == 0 ? Colors.yellow : Colors.grey),
                    const SizedBox(height: 5),
                    Text(
                      "Watch List",
                      style: TextStyle(
                        color: activeIndex == 0 ? Colors.yellow : Colors.grey,
                        fontWeight: activeIndex == 0 ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () => setState(() => activeIndex = 1),
                child: Column(
                  children: [
                    Icon(Icons.history, color: activeIndex == 1 ? Colors.yellow : Colors.grey),
                    const SizedBox(height: 5),
                    Text(
                      "History",
                      style: TextStyle(
                        color: activeIndex == 1 ? Colors.yellow : Colors.grey,
                        fontWeight: activeIndex == 1 ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: Container(
                height: 2,
                color: activeIndex == 0 ? Colors.yellow : Colors.white12,
              ),
            ),
            Expanded(
              child: Container(
                height: 2,
                color: activeIndex == 1 ? Colors.yellow : Colors.white12,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
