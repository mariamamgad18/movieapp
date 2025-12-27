import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/Utils/AppImages.dart';
import '../../Cubit/HomeScreenCubit/Home_Screen_States.dart';
import '../../Cubit/HomeScreenCubit/Home_Screen_View_Model.dart';
import '../../Utils/AppColors.dart';
import '../../models/movies_response.dart';
import '../Browse_Page.dart';
import 'MovieItem.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final PageController _pageController =
  PageController(viewportFraction: 0.6, initialPage: 0);

  late HomeScreenViewModel homeScreenViewModel;

  @override
  void initState() {
    super.initState();
    homeScreenViewModel = HomeScreenViewModel();
    homeScreenViewModel.getMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeScreenViewModel, HomeScreenStates>(
        bloc: homeScreenViewModel,
        builder: (context, state) {
          if (state is HomeLoadingState) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.yellow),
            );
          }

          if (state is HomeErrorState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Something went wrong!\n${state.errorMsg}",
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.red, fontSize: 18),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {
                      homeScreenViewModel.getMovies();
                    },
                    child: const Text("Try Again"),
                  ),
                ],
              ),
            );
          }

          if (state is HomeSuccessState) {
            final allMovies = state.allMovies;
            final groupedMovies = state.groupedMovies;

            return Stack(
              children: [
                Image.asset(
                  Appimages.homebackground,
                  fit: BoxFit.fill,
                  width: double.infinity,
                  height: double.infinity,
                ),
                ListView(
                  padding: const EdgeInsets.only(
                      top: 114, left: 15, right: 15, bottom: 100),
                  children: [
                    // Carousel للأفلام
                    SizedBox(
                      height: 260,
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: allMovies.length,
                        itemBuilder: (context, index) {
                          return AnimatedBuilder(
                            animation: _pageController,
                            builder: (context, child) {
                              double value = 1.0;
                              if (_pageController.position.haveDimensions) {
                                value = _pageController.page! - index;
                                value = (1 - (value.abs() * 0.3)).clamp(0.0, 1.0);
                              } else {
                                value = index == 0 ? 1.0 : 0.7;
                              }
                              return Center(
                                child: SizedBox(
                                  height: 260 * value,
                                  child: child,
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 12),
                              child: Movieitem(movies: allMovies[index]),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 40),

                    ...groupedMovies.entries.map((entry) {
                      final genreName = entry.key;
                      final genreMovies = entry.value;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 70),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                genreName,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          BrowsePage(selectedGenre: genreName),
                                    ),
                                  );
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      "See More",
                                      style: TextStyle(
                                        color: Appcolors.yellowColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    Icon(Icons.arrow_forward_outlined,
                                        color: Appcolors.yellowColor, size: 16)
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          SizedBox(
                            height: 260,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: genreMovies.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 12),
                                  child: Movieitem(movies: genreMovies[index]),
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ],
                ),
              ],
            );
          }

          return const SizedBox(); // fallback
        },
      ),
    );
  }
}
