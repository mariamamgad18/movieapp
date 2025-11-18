import 'package:flutter/material.dart';
import 'package:movieapp/Utils/AppColors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../resetpassword/resetpassword_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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

  int selectedAvatarIndex = 0;
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      nameController.text = prefs.getString('name') ?? '';
      phoneController.text = prefs.getString('phone') ?? '';
      selectedAvatarIndex = prefs.getInt('avatarId') ?? 0;
    });
  }

  Future<void> _saveUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', nameController.text);
    await prefs.setString('phone', phoneController.text);
    await prefs.setInt('avatarId', selectedAvatarIndex);
  }

  void _showAvatarPicker() async {
    final selected = await showModalBottomSheet<int>(
      context: context,
      backgroundColor: Appcolors.grayColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return SizedBox(
          height: 320,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: GridView.builder(
              itemCount: avatarPaths.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, crossAxisSpacing: 16, mainAxisSpacing: 16),
              itemBuilder: (context, index) {
                final isSelected = index == selectedAvatarIndex;
                return GestureDetector(
                  onTap: () {
                    Navigator.pop(context, index);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: isSelected ? Appcolors.yellowColor : null,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                          color: isSelected ? Appcolors.yellowColor : Colors.transparent,
                          width: 3),
                    ),
                    padding: const EdgeInsets.all(6),
                    child: CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage(avatarPaths[index]),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );

    if (selected != null && selected != selectedAvatarIndex) {
      setState(() {
        selectedAvatarIndex = selected;
      });
      await _saveUserData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors.blackColor,
      appBar: AppBar(
        backgroundColor: Appcolors.grayColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Appcolors.yellowColor,
          onPressed: () {
            Navigator.maybePop(context);
          },
        ),
        title: Text(
          'Profile',
          style: TextStyle(color: Appcolors.yellowColor, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 120),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  GestureDetector(
                    onTap: _showAvatarPicker,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage(avatarPaths[selectedAvatarIndex]),
                    ),
                  ),
                  const SizedBox(height: 24),
                  TextField(
                    controller: nameController,
                    style: TextStyle(color: Appcolors.whitekColor),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[850],
                      prefixIcon: Icon(Icons.person, color: Appcolors.whitekColor),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding:
                      const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    style: TextStyle(color: Appcolors.whitekColor),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[850],
                      prefixIcon: Icon(Icons.phone, color: Appcolors.whitekColor),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding:
                      const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ResetPasswordScreen(),
                          ),
                        );
                      },
                      style: TextButton.styleFrom(
                          padding: EdgeInsets.zero, visualDensity: VisualDensity.compact),
                      child: Text(
                        'Reset Password',
                        style: TextStyle(color: Appcolors.whitekColor, fontSize: 14),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _saveUserData, // حفظ الاسم، رقم الموبايل والأفاتار
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Appcolors.yellowColor,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('Update Data'),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
