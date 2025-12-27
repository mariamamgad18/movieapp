import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Api/Api_Manager.dart';
import '../Cubit/FavoriteCubit/FavoriteCubit.dart';
import '../Cubit/ProfileCubit/Profile_View_Model.dart';
import '../Data/ProfileData/DataSource/Impl/ProfileRemoteDataSourceImpl.dart';
import '../Data/ProfileData/Repository/Impl/ProfileRepositoryImpl.dart';
import '../Pages/Browse_Page.dart';
import '../Pages/HomeTab/Home.dart';
import '../Pages/Profile_Page.dart';
import '../Pages/Search_Page.dart';
import 'bottom_navigation_bar.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({super.key});

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  int currentIndex = 0;

  final List<Widget> pages = [
    Home(),
    SearchPage(),
    BrowsePage(selectedGenre: ''),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => ProfileViewModel()..loadFavorites(),
        ),
        BlocProvider(
          create: (_) {
            final apiManager = ApiManager();

            return FavoriteCubit(
              ProfileRepositoryImpl(
                profileRemoteDataSource:
                ProfileRemoteDataSourceImpl(apiManager: apiManager),
              ),
              apiManager,
            )..loadFavorites();
          },
        ),
      ],
      child: Scaffold(
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
      ),
    );
  }
}
