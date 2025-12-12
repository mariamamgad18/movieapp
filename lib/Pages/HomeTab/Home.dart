import 'package:flutter/material.dart';
import 'package:movieapp/Utils/AppImages.dart';

import '../../Api/Api_Manager.dart';
import '../../Utils/AppColors.dart';
import '../../models/movies_response.dart';
import '../Browse_Page.dart';
import 'MovieItem.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<MoviesResponse>? _moviesFuture;
  late Future<Map<String, List<Movies>>> _groupedMoviesFuture;

  // PageController للـ Carousel
  final PageController _pageController =
  PageController(viewportFraction: 0.6, initialPage: 0);

  @override
  void initState() {
    super.initState();
    _moviesFuture = ApiManager().getMovies();
    _groupedMoviesFuture = ApiManager().getMoviesGroupedByGenre();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<MoviesResponse>(
          future: _moviesFuture,
          builder: (context, snapshotAll) {
            if (snapshotAll.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.yellow),
              );
            }

            if (snapshotAll.hasError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Something went wrong!\n${snapshotAll.error}",
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.red, fontSize: 18),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _moviesFuture = ApiManager().getMovies();
                        });
                      },
                      child: const Text("Try Again"),
                    ),
                  ],
                ),
              );
            }

            final moviesList = snapshotAll.data?.data?.movies ?? [];

            return FutureBuilder<Map<String, List<Movies>>>(
              future: _groupedMoviesFuture,
              builder: (context, snapshotGrouped) {
                final groupedMovies = snapshotGrouped.data ?? {};

                return Stack(
                  children: [
                    Image(
                      image: AssetImage(Appimages.homebackground),
                      fit: BoxFit.fill,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                    ListView(
                      padding: const EdgeInsets.only(
                          top: 114, left: 15, right: 15, bottom: 100),
                      children: [
                        SizedBox(
                          height: 260,
                          child: PageView.builder(
                            controller: _pageController,
                            itemCount: moviesList.length,
                            itemBuilder: (context, index) {
                              return AnimatedBuilder(
                                animation: _pageController,
                                builder: (context, child) {
                                  double value = 1.0;
                                  if (_pageController.position.haveDimensions) {
                                    value = _pageController.page! - index;
                                    value =
                                        (1 - (value.abs() * 0.3)).clamp(0.0, 1.0);
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
                                  child: Movieitem(movies: moviesList[index]),
                                ),
                              );
                            },
                          ),
                        ),

                        const SizedBox(height: 40),
                        if (snapshotGrouped.connectionState == ConnectionState.waiting)
                          const Center(
                            child: CircularProgressIndicator(color: Colors.yellow),
                          )
                        else if (snapshotGrouped.hasError)
                          Center(
                            child: Text(
                              "Error loading grouped movies\n${snapshotGrouped.error}",
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: Colors.red),
                            ),
                          )
                        else
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
              },
            );
          },
        ),
      ),
    );
  }
}
