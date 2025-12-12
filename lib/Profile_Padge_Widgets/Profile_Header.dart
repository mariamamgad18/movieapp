import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Api/Api_Manager.dart';
import 'Status_Items.dart';

class ProfileHeader extends StatefulWidget {
  const ProfileHeader({super.key});

  @override
  State<ProfileHeader> createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {
  String userName = "No User";
  int avatar = 0;

  final List<String> avatarPaths = [
    'assets/images/gamer (1).png',
    'assets/images/gamer (2).png',
    'assets/images/gamer (3).png',
    'assets/images/gamer (4).png',
    'assets/images/gamer (5).png',
    'assets/images/gamer (6).png',
    'assets/images/gamer (7).png',
    'assets/images/gamer (8).png',
  ];

  @override
  void initState() {
    super.initState();
    loadUserProfile();
  }

  Future<void> loadUserProfile() async {
    try {
      final profile = await ApiManager().getProfile();
      SharedPreferences prefs = await SharedPreferences.getInstance();

      if (profile.data == null) {
        await prefs.clear();
        setState(() {
          userName = "No User";
          avatar = 0;
        });
        return;
      }

      await prefs.setInt('avatarId', profile.data?.avaterId ?? 0);
      await prefs.setString('userName', profile.data?.name ?? "");

      setState(() {
        userName = profile.data?.name ?? "No User";
        avatar = profile.data?.avaterId ?? 0;
      });
    } catch (e) {
      // لو API فشل، حاول تجيب البيانات من SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        userName = prefs.getString('userName') ?? "No User";
        avatar = prefs.getInt('avatarId') ?? 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage(
                avatarPaths[avatar.clamp(0, avatarPaths.length - 1)],
              ),
            ),
            const SizedBox(height: 10),
            Text(
              userName,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.only(top: 25),
          child: Row(
            children: const [
              StatusItem(
                number: "  12",
                label: "Wish List",
                numberColor: Colors.white,
                labelColor: Colors.white,
                numberFontSize: 36,
                labelFontSize: 24,
              ),
              SizedBox(width: 40),
              StatusItem(
                number: "  10",
                label: "History",
                numberColor: Colors.white,
                labelColor: Colors.white,
                numberFontSize: 36,
                labelFontSize: 24,
              ),
            ],
          ),
        ),
        const Spacer(),
      ],
    );
  }
}
