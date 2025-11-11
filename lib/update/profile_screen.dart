import 'package:flutter/material.dart';
import 'package:movieapp/Utils/AppColors.dart';

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
    'assets/images/gamer (4).png',
  ];

  int selectedAvatarIndex = 0;

  final TextEditingController nameController = TextEditingController(text: "John Safwat");
  final TextEditingController phoneController = TextEditingController(text: "01200000000");

  void _showAvatarPicker() async {
    final selected = await showModalBottomSheet<int>(
      context: context,
      backgroundColor:Appcolors.grayColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isScrollControlled: false,
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
          color:Appcolors.yellowColor,
          onPressed: () {
            Navigator.maybePop(context);
          },
        ),
        title:  Text(
          'Pick Avatar',
          style: TextStyle(color: Appcolors.yellowColor,
              fontWeight: FontWeight.w600),
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
                    style:  TextStyle(color: Appcolors.whitekColor),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[850],
                      prefixIcon:  Icon(Icons.person, color: Appcolors.whitekColor),
                      hintText: 'John Safwat',
                      hintStyle:  TextStyle(color: Appcolors.whitekColor),
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
                    style:  TextStyle(color: Appcolors.whitekColor),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[850],
                      prefixIcon:  Icon(Icons.phone, color: Appcolors.whitekColor),
                      hintText: '01200000000',
                      hintStyle:  TextStyle(color: Appcolors.whitekColor),
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
                      onPressed: () {
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Appcolors.redColor,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('Delete Account'),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                      },
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