import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/Ui/MovieDeatails/CastContainer.dart';
import 'package:movieapp/Ui/MovieDeatails/GenereItem.dart';
import 'package:movieapp/Ui/MovieDeatails/ScereenShots.dart';
import 'package:movieapp/Utils/AppColors.dart';
import 'package:movieapp/Utils/AppImages.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../Cubit/FavoriteCubit/FavoriteCubit.dart';
import '../../Cubit/FavoriteCubit/FavoriteState.dart';
import '../../Cubit/MovieDetailsScreenCubit/Get_Movie_Details_States.dart';
import '../../Cubit/MovieDetailsScreenCubit/Get_Movie_Details_View_model.dart';
import '../../Pages/HomeTab/MovieItem.dart';
import '../../models/GetAllFavoritesMovies.dart' as fav;
import '../../models/movies_response.dart';
import 'ReactsContainer.dart';

class Moviedetailsscreen extends StatefulWidget {
  final int movieId;
  final VoidCallback? onFavoriteChanged;

  Moviedetailsscreen({super.key, required this.movieId, this.onFavoriteChanged});

  @override
  State<Moviedetailsscreen> createState() => _MoviedetailsscreenState();
}

class _MoviedetailsscreenState extends State<Moviedetailsscreen> {
  late GetMovieDetailsViewModel movieDetailsViewModel;

  @override
  void initState() {
    super.initState();
    movieDetailsViewModel = GetMovieDetailsViewModel();
    movieDetailsViewModel.getMovieDetails(movieId: widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<GetMovieDetailsViewModel, GetMovieDetailsStates>(
        bloc: movieDetailsViewModel,
        builder: (context, state) {
          if (state is GetMovieDetailsLoadingStates) {
            return Center(
              child: CircularProgressIndicator(color: Appcolors.yellowColor),
            );
          } else if (state is GetMovieDetailsErrorStates) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Something went wrong!\n${state.ErrorMsg}",
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.red, fontSize: 18),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {
                      movieDetailsViewModel.getMovieDetails(movieId: widget.movieId);
                    },
                    child: const Text("Try Again"),
                  ),
                ],
              ),
            );
          } else if (state is GetMovieDetailsSuccessStates) {
            final movie = state.movie;
            final suggestions = state.SuggMovies;
            String? description = movie.descriptionFull;

            if (description != null) {
              description = description.replaceAll(r'\"', '"');
              if (description.startsWith('"') && description.endsWith('"')) {
                description = description.substring(1, description.length - 1);
              }
            }

            return SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Trailer
                    state.showTrailer
                        ? YoutubePlayer(
                      controller: YoutubePlayerController(
                        initialVideoId: movie.ytTrailerCode ?? "",
                        flags: const YoutubePlayerFlags(
                          autoPlay: true,
                          mute: false,
                        ),
                      ),
                      showVideoProgressIndicator: true,
                      progressIndicatorColor: Appcolors.redColor,
                    )
                        : Stack(
                      children: [
                        Image.network(
                          movie.largeCoverImage ?? '',
                          width: double.infinity,
                          height: 766,
                          fit: BoxFit.fill,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(17.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: Image.asset(
                                  Appimages.back,
                                  width: 17,
                                  height: 29,
                                ),
                              ),
                              BlocBuilder<FavoriteCubit, FavoriteState>(
                                builder: (context, favState) {
                                  final cubit = context.read<FavoriteCubit>();
                                  final isFav = cubit.isMovieFavorite(movie.id.toString());

// تحويل الفيلم إلى fav.Data عشان Cubit يتعامل معاه
                                  final movieAsData = fav.Data(
                                    movieId: movie.id.toString(),
                                    name: movie.title,
                                    imageURL: movie.largeCoverImage,
                                    rating: movie.rating,
                                    year: movie.year.toString(),
                                  );

                                  return InkWell(
                                    onTap: () {
                                      // نستخدم toggleFavorite من Cubit
                                      cubit.toggleFavorite(
                                        isFavorite: isFav,
                                        movieData: movieAsData, // استخدم movieAsData هنا
                                      );

                                      // رسالة تنبيه للمستخدم
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            isFav
                                                ? "Movie removed from favorites"
                                                : "Movie added to favorites",
                                          ),
                                          backgroundColor: Colors.yellow,
                                          duration: const Duration(seconds: 2),
                                        ),
                                      );

                                      // لو فيه callback لتحديث واجهة خارجية
                                      if (widget.onFavoriteChanged != null) {
                                        widget.onFavoriteChanged!();
                                      }
                                    },
                                    child: Image.asset(
                                      Appimages.save,
                                      width: 20,
                                      height: 29,
                                      color: isFav ? Colors.yellow : Colors.white,
                                    ),
                                  );

                                },
                              )
                            ],
                          ),
                        ),
                        Positioned(
                          bottom: 20,
                          left: 0,
                          right: 0,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    movieDetailsViewModel.emit(
                                      GetMovieDetailsSuccessStates(
                                        movie: movie,
                                        SuggMovies: suggestions,
                                        IsFavorite: state.IsFavorite,
                                        showTrailer: true,
                                      ),
                                    );
                                  },
                                  child: Image.asset(Appimages.play),
                                ),
                                const SizedBox(height: 190),
                                Text(
                                  movie.titleLong ?? "No Title",
                                  style:  TextStyle(
                                    color: Appcolors.whitekColor,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  movie.year?.toString() ?? "Unknown Year",
                                  style:  TextStyle(
                                    color: Appcolors.grayColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    child:  Text(
                                      "Watch",
                                      style: TextStyle(
                                        color: Appcolors.whitekColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Appcolors.redColor,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(15)),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 16, horizontal: 121),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Reactscontainer(
                                        iconName: Appimages.likes,
                                        NumerOfreacts: movie.likeCount?.toDouble() ?? 0,
                                      ),
                                    ),
                                    Expanded(
                                      child: Reactscontainer(
                                        iconName: Appimages.watch,
                                        NumerOfreacts: movie.rating?.toDouble() ?? 0,
                                      ),
                                    ),
                                    Expanded(
                                      child: Reactscontainer(
                                        iconName: Appimages.fav,
                                        NumerOfreacts: movie.runtime?.toDouble() ?? 0,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Screenshots
                           Text(
                            "Screen Shots",
                            style: TextStyle(
                              color: Appcolors.whitekColor,
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          if (movie.largeScreenshotImage1 != null)
                            Scereenshots(ScreenShotsImage: movie.largeScreenshotImage1!),
                          if (movie.largeScreenshotImage2 != null)
                            Scereenshots(ScreenShotsImage: movie.largeScreenshotImage2!),
                          if (movie.largeScreenshotImage3 != null)
                            Scereenshots(ScreenShotsImage: movie.largeScreenshotImage3!),
                          const SizedBox(height: 16),

                          // Similar movies
                           Text(
                            "Similar",
                            style: TextStyle(
                              color: Appcolors.whitekColor,
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 8),
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 12,
                              crossAxisSpacing: 12,
                              childAspectRatio: 170 / 240,
                            ),
                            itemCount: suggestions.length > 4 ? 4 : suggestions.length,
                            itemBuilder: (context, index) {
                              final suggMovie = suggestions[index];
                              return Movieitem(
                                movies: Movies(
                                  id: suggMovie.id,
                                  mediumCoverImage: suggMovie.mediumCoverImage,
                                  largeCoverImage: suggMovie.backgroundImage ?? '',
                                  rating: suggMovie.rating,
                                ),
                              );
                            },
                          ),

                          const SizedBox(height: 16),
                           Text(
                            "Summary",
                            style: TextStyle(
                              color: Appcolors.whitekColor,
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            description?.isNotEmpty == true
                                ? description!
                                : 'No description available',
                            style:  TextStyle(
                              color: Appcolors.whitekColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                            softWrap: true,
                          ),
                          const SizedBox(height: 16),

                          // Cast
                          if (movie.cast != null && movie.cast!.isNotEmpty)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Cast",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.w700),
                                ),
                                const SizedBox(height: 10),
                                ...movie.cast!.map(
                                      (c) => Castcontainer(
                                    CastImage: c.urlSmallImage ?? Appimages.cast1,
                                    CastName: c.name ?? "Unknown",
                                    CharacterName: c.characterName ?? "",
                                  ),
                                ),
                              ],
                            ),

                          const SizedBox(height: 8),
                          Text(
                            "Genres",
                            style: TextStyle(
                              color: Appcolors.whitekColor,
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Wrap(
                            alignment: WrapAlignment.start,
                            spacing: 16,
                            runSpacing: 11,
                            children:
                            movie.genres!.map((g) => Genereitem(Genere: g)).toList(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
