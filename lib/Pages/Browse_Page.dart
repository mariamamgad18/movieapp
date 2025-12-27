import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/Cubit/BrowseCubit/Browse_View_Model.dart';
import 'package:movieapp/Cubit/BrowseCubit/Browse_States.dart';
import 'package:movieapp/utils/AppColors.dart';

import 'HomeTab/MovieItem.dart';

class BrowsePage extends StatefulWidget {
  final String selectedGenre;

  const BrowsePage({super.key, required this.selectedGenre});

  @override
  State<BrowsePage> createState() => _BrowsePageState();
}

class _BrowsePageState extends State<BrowsePage> {
  late BrowseViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = BrowseViewModel();
    viewModel.loadMovies(widget.selectedGenre);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BrowseViewModel, BrowseStates>(
      bloc: viewModel,
      builder: (context, state) {
        if (state is BrowseLoadingState) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is BrowseErrorState) {
          return Scaffold(
            body: Center(child: Text(state.errorMsg)),
          );
        }

        if (state is BrowseSuccessState) {
          final filteredMovies = state.allMovies
              .where((m) => m.genres?.contains(state.selectedGenre) ?? false)
              .toList();

          return SafeArea(
            child: Scaffold(
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Genres chips
                  SizedBox(
                    height: 80,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: state.genres.map((genre) {
                        final isSelected = genre == state.selectedGenre;
                        return GestureDetector(
                          onTap: () {
                            viewModel.changeGenre(genre);
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

                  /// Movies Grid
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

        return const SizedBox();
      },
    );
  }
}
