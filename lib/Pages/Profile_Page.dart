import 'package:flutter/material.dart';

import '../Api/Api_Manager.dart';
import '../Profile_Padge_Widgets/Action_Button_Row.dart';
import '../Profile_Padge_Widgets/Body_Photo.dart';
import '../Profile_Padge_Widgets/Profile_Header.dart';
import '../Profile_Padge_Widgets/Tabs.dart';
import '../models/GetAllFavoritesMovies.dart';
import 'HomeTab/MovieItem.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int selectedTab = 0;
  List<Data> favorites = []; // قائمة محلية بدلاً من Future
  bool isLoading = true; // عشان نعرض loading
  int watchListCount = 0;

  @override
  void initState() {
    super.initState();
    loadFavorites(); // احمل البيانات في البداية
  }

  Future<void> loadFavorites() async {
    try {
      final response = await ApiManager().getAllFavoritesMovies();
      setState(() {
        favorites = response.data ?? [];
        watchListCount = favorites.length;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      // يمكنك إضافة رسالة خطأ هنا
    }
  }

  void refreshFavorites() async {
    await loadFavorites(); // أعد تحميل البيانات وحدث القائمة
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileHeader(
              watchListCount: watchListCount,
            ),
            const SizedBox(height: 24),
            const ActionButtonsRow(),
            const SizedBox(height: 30),
            TabsSection(
              onTabChanged: (index) {
                setState(() {
                  selectedTab = index;
                });
              },
            ),
            const SizedBox(height: 20),
            selectedTab == 0
                ? SizedBox(
              height: 500,
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : favorites.isEmpty
                  ? const Center(
                  child: Text(
                    "No movies in Watch List",
                    style: TextStyle(color: Colors.white),
                  ))
                  : GridView.builder(
                padding: const EdgeInsets.all(8),
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.65,
                ),
                itemCount: favorites.length,
                itemBuilder: (context, index) {
                  return Movieitem(
                    movie: favorites[index],
                    onFavoriteChanged: refreshFavorites,
                  );
                },
              ),
            )
                : const Center(
                child: Text(
                  "History",
                  style: TextStyle(color: Colors.white),
                )),
            const SizedBox(height: 60),
            const CenteredPhoto(),
          ],
        ),
      ),
    );
  }
}