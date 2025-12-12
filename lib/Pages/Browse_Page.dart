import 'package:flutter/material.dart';
import 'package:movieapp/Api/Api_Manager.dart';
import 'package:movieapp/models/movies_response.dart';
import 'package:movieapp/utils/AppColors.dart';

import 'HomeTab/MovieItem.dart';

class BrowsePage extends StatefulWidget {
  final String selectedGenre;

  const BrowsePage({super.key, required this.selectedGenre});

  @override
  State<BrowsePage> createState() => _BrowsePageState();
}

class _BrowsePageState extends State<BrowsePage> {
  final api = ApiManager();

  List<Movies> allMovies = [];
  List<String> genres = [];
  late String selectedGenre;

  bool loading = true;
  String? errorMsg;

  @override
  void initState() {
    super.initState();
    selectedGenre = widget.selectedGenre;
    loadMovies();
  }

  Future<void> loadMovies() async {
    try {
      final response = await api.getMovies();
      allMovies = response.data?.movies ?? [];

      final Set<String> genreSet = {};
      for (var movie in allMovies) {
        genreSet.addAll(movie.genres ?? []);
      }
      genres = genreSet.toList();

      setState(() => loading = false);
    } catch (e) {
      setState(() {
        loading = false;
        errorMsg = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredMovies = allMovies
        .where((m) => m.genres?.contains(selectedGenre) ?? false)
        .toList();

    return SafeArea(
      child: Scaffold(
        body: loading
            ? const Center(child: CircularProgressIndicator())
            : errorMsg != null
            ? Center(child: Text(errorMsg!))
            : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 80,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: genres.map((genre) {
                  final isSelected = genre == selectedGenre;
                  return GestureDetector(
                    onTap: () {
                      setState(() => selectedGenre = genre);
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 12),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Appcolors.yellowColor,
                          width: 2,
                        ),
                        color: isSelected
                            ? Appcolors.yellowColor
                            : Appcolors.transparentColor,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Center(
                        child: Text(
                          genre,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: isSelected
                                ? Appcolors.blackColor
                                : Appcolors.yellowColor,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

            Expanded(
              child: GridView.builder(
                itemCount: filteredMovies.length,
                padding: const EdgeInsets.all(12),
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: .62,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemBuilder: (context, i) {
                  return Movieitem(movies: filteredMovies[i]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
