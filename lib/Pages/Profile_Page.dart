import 'package:flutter/material.dart';
import '../Profile_Padge_Widgets/Action_Button_Row.dart';
import '../Profile_Padge_Widgets/Body_Photo.dart';
import '../Profile_Padge_Widgets/Profile_Header.dart';
import '../Profile_Padge_Widgets/Tabs.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            ProfileHeader(),
            SizedBox(height: 24),
            ActionButtonsRow(),
            SizedBox(height: 30),
            TabsSection(),
            SizedBox(height: 60),
             CenteredPhoto(),
          ],
        ),
      ),
    );
  }
}
