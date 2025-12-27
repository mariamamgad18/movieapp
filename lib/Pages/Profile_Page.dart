import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Cubit/ProfileCubit/Profile_States.dart';
import '../Cubit/ProfileCubit/Profile_View_Model.dart';
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

  @override
  void initState() {
    super.initState();
    context.read<ProfileViewModel>().loadFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileViewModel, ProfileStates>(
      builder: (context, state) {

        List<Data> favorites = [];
        int watchListCount = 0;
        bool isLoading = false;

        if (state is ProfileLoadingState) {
          isLoading = true;
        } else if (state is ProfileSuccessState) {
          favorites = state.favorites;
          watchListCount = state.watchListCount;
        } else if (state is ProfileErrorState) {
          return Center(child: Text(state.errorMsg));
        }

        return Scaffold(
          backgroundColor: Colors.black,
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProfileHeader(watchListCount: watchListCount),
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
                    ),
                  )
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
                        onFavoriteChanged: () => context
                            .read<ProfileViewModel>()
                            .loadFavorites(),
                      );
                    },
                  ),
                )
                    : const Center(
                  child: Text(
                    "History",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 60),
                const CenteredPhoto(),
              ],
            ),
          ),
        );
      },
    );
  }
}
