import 'package:flutter/material.dart';
import 'package:movieapp/Utils/AppColors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Api/Api_Manager.dart';
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

  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  Future<void>? _profileFuture;

  @override
  void initState() {
    super.initState();
    _profileFuture = _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    try {
      final profile = await ApiManager().getProfile();
      SharedPreferences prefs = await SharedPreferences.getInstance();

      setState(() {
        emailController.text = profile.data?.email ?? '';
        phoneController.text = profile.data?.phone ?? '';
        selectedAvatarIndex = profile.data?.avaterId ?? 0;

        prefs.setString('email', emailController.text);
        prefs.setString('phone', phoneController.text);
        prefs.setInt('avatarId', selectedAvatarIndex);
      });
    } catch (e) {
      print('Error fetching profile: $e');
    }
  }

  Future<void> _updateProfile() async {
    try {
      Map<String, dynamic> body = {
        "avaterId": selectedAvatarIndex,
        "email": emailController.text,
        "phone": phoneController.text,
      };

      await ApiManager().updateProfile(body);

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setInt('avatarId', selectedAvatarIndex);
      await prefs.setString('email', emailController.text);
      await prefs.setString('phone', phoneController.text);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update profile: $e')),
      );
    }
  }

  Future<void> _deleteAccount() async {
    try {
      await ApiManager().deleteProfile();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.clear();

      setState(() {
        selectedAvatarIndex = 0;
        emailController.text = "";
        phoneController.text = "";
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Account deleted successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete account: $e')),
      );
    }
  }

  Future<void> _saveUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', emailController.text);
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
                crossAxisCount: 3,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemBuilder: (context, index) {
                final isSelected = index == selectedAvatarIndex;
                return GestureDetector(
                  onTap: () => Navigator.pop(context, index),
                  child: Container(
                    decoration: BoxDecoration(
                      color: isSelected ? Appcolors.yellowColor : null,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                          color: isSelected
                              ? Appcolors.yellowColor
                              : Colors.transparent,
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
      setState(() => selectedAvatarIndex = selected);
      await _saveUserData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _profileFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          return Scaffold(
            body: Center(child: Text('Error loading profile')),
          );
        }

        return Scaffold(
          backgroundColor: Appcolors.blackColor,
          appBar: AppBar(
            backgroundColor: Appcolors.transparentColor,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              color: Appcolors.yellowColor,
              onPressed: () => Navigator.maybePop(context),
            ),
            title: Text(
              'Pick Avatar',
              style: TextStyle(
                color: Appcolors.yellowColor,
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
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
                          backgroundImage:
                          AssetImage(avatarPaths[selectedAvatarIndex]),
                        ),
                      ),
                      const SizedBox(height: 24),

                      /// EMAIL (editable)
                      TextField(
                        controller: emailController,
                        readOnly: false,
                        style: TextStyle(color: Appcolors.whitekColor),
                        decoration: InputDecoration(
                          prefixIcon:
                          Icon(Icons.email, color: Appcolors.whitekColor),
                          labelStyle: TextStyle(color: Appcolors.whitekColor),
                          filled: true,
                          fillColor: Colors.grey[850],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      /// PHONE (editable)
                      TextField(
                        controller: phoneController,
                        readOnly: false,
                        style: TextStyle(color: Appcolors.whitekColor),
                        decoration: InputDecoration(
                          prefixIcon:
                          Icon(Icons.phone, color: Appcolors.whitekColor),
                          labelStyle: TextStyle(color: Appcolors.whitekColor),
                          filled: true,
                          fillColor: Colors.grey[850],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
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
                                builder: (context) =>
                                const ResetPasswordScreen(),
                              ),
                            );
                          },
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            visualDensity: VisualDensity.compact,
                          ),
                          child: Text(
                            'Reset Password',
                            style: TextStyle(
                                color: Appcolors.whitekColor, fontSize: 14),
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
                  padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _deleteAccount,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'Delete Account',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _updateProfile,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Appcolors.yellowColor,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            'Update Data',
                            style: TextStyle(color: Appcolors.blackColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
