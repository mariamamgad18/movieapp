import 'package:flutter/material.dart';
import 'package:movieapp/Api/Api_Manager.dart';
import 'package:movieapp/Ui/MovieDeatails/CastContainer.dart';
import 'package:movieapp/Ui/MovieDeatails/GenereItem.dart';
import 'package:movieapp/Ui/MovieDeatails/ScereenShots.dart';
import 'package:movieapp/Utils/AppColors.dart';
import 'package:movieapp/Utils/AppImages.dart';
import 'package:movieapp/models/MovieDetailsResponse.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../Pages/HomeTab/MovieItem.dart';
import '../../models/MovieSuggestion.dart';
import '../../models/movies_response.dart';
import 'ReactsContainer.dart';

class Moviedetailsscreen extends StatefulWidget {
  int movieId;
  final VoidCallback? onFavoriteChanged;

  Moviedetailsscreen({super.key, required this.movieId, this.onFavoriteChanged});

  @override
  State<Moviedetailsscreen> createState() => _MoviedetailsscreenState();
}
class _MoviedetailsscreenState extends State<Moviedetailsscreen> {
  late Future<MovieDetailsResponse> _MovieDetails;
  bool isSaved = false;
  bool showTrailerVedio = false;

  @override
  void initState() {
    super.initState();
    _MovieDetails = ApiManager().getMovieDetails(movieId: widget.movieId);
    checkIfFavorite();
  }

  void checkIfFavorite() async {
    //بنبعت ريكوست للسيرفر نعرف منه الفيلم موجود ف الفيوريت ولا لا
    final favResponse = await ApiManager().movieIsFavorite(movieId: widget.movieId.toString());
    setState(() {
      isSaved = favResponse.data; // true لو موجود في الفيفوريت، false لو مش موجود
    });
  }



  void saveFavoriteLocally(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('favorite_${widget.movieId}', value);
  }

  void loadFavoriteLocally() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isSaved = prefs.getBool('favorite_${widget.movieId}') ?? false;
    });
  }


  @override
  Widget build(BuildContext context) {
      return Scaffold(
          body: FutureBuilder<MovieDetailsResponse>
            (
              future: _MovieDetails,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                        color: Appcolors.yellowColor),
                  );
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Something went wrong!\n${snapshot.error}",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: Colors.red, fontSize: 18),
                        ),
                        const SizedBox(height: 12),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _MovieDetails =
                                  ApiManager().getMovieDetails(
                                      movieId: widget.movieId);
                            });
                          },
                          child: const Text("Try Again"),
                        ),
                      ],
                    ),
                  );
                }
                final movie = snapshot.data?.data?.movie;

                if (movie == null) {
                  return const Center(
                    child: Text("Movie details not found."),
                  );
                }


                String? description = movie.descriptionFull;
                print('Original descriptionFull: $description');

                if (description != null) {
                  description = description.replaceAll(r'\"', '"');
                  if (description.startsWith('"') &&
                      description.endsWith('"')) {
                    description =
                        description.substring(1, description.length - 1);
                  }
                }

                print('Processed description: $description');


                return SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        showTrailerVedio ?
                        YoutubePlayer(
                          controller: YoutubePlayerController(
                            initialVideoId: movie.ytTrailerCode ?? "",
                            flags: const YoutubePlayerFlags(
                              autoPlay: true,
                              mute: false,
                            ),
                          ),
                          showVideoProgressIndicator: true,
                          progressIndicatorColor: Appcolors.redColor,
                        ) :
                        Stack(
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
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  InkWell(
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Image.asset(
                                        Appimages.back,
                                        width: 17,
                                        height: 29,
                                      )),



                                  InkWell(
                                    onTap: () async {
                                      final prefs = await SharedPreferences.getInstance();

                                      setState(() {
                                        isSaved = !isSaved;
                                      });

                                      if (!isSaved) {
                                        final removeResponse = await ApiManager().RemoveMovieFromFavorite(
                                            movieId: movie.id.toString());
                                        if (removeResponse.statusCode == 200) {
                                          prefs.setBool('favorite_${movie.id}', false);

                                          // تحديث الـ GridView في ProfilePage
                                          if (widget.onFavoriteChanged != null) {
                                            widget.onFavoriteChanged!();
                                          }

                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(
                                              content: Text("Movie removed from favorites"),
                                              backgroundColor: Colors.yellow,
                                              duration: Duration(seconds: 2),
                                            ),
                                          );
                                        }
                                      } else {
                                        await ApiManager().AddMovieToFavorite(
                                          movieId: movie.id.toString(),
                                          name: movie.title ?? '',
                                          rating: movie.rating?.toDouble() ?? 0.0,
                                          imageURL: movie.largeCoverImage ?? '',
                                          year: movie.year.toString(),
                                        );
                                        prefs.setBool('favorite_${movie.id}', true);

                                        if (widget.onFavoriteChanged != null) {
                                          widget.onFavoriteChanged!();
                                        }

                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(
                                            content: Text("Movie added to favorites"),
                                            backgroundColor: Colors.yellow,
                                            duration: Duration(seconds: 2),
                                          ),
                                        );
                                      }
                                    },
                                    child: Image.asset(
                                      Appimages.save,
                                      width: 20,
                                      height: 29,
                                      color: isSaved ? Colors.yellow : Colors.white,
                                    ),
                                  )


                                ],
                              ),
                            ),


                            Positioned(
                              bottom: 20,
                              left: 0,
                              right: 0,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [

                                    InkWell(onTap: () {
                                      setState(() {
                                        showTrailerVedio = true;
                                      });
                                    },
                                        child: Image(
                                            image: AssetImage(Appimages.play))),
                                    SizedBox(height: 190),

                                    Text(
                                      movie.titleLong ?? "No Title",
                                      style: TextStyle(
                                        color: Appcolors.whitekColor,
                                        fontSize: 24,
                                        fontWeight: FontWeight.w700,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      movie.year?.toString() ?? "Unknown Year",
                                      style: TextStyle(
                                        color: Appcolors.grayColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    SizedBox(height: 12),
                                    SizedBox(width: double.infinity,
                                      child: ElevatedButton(
                                        onPressed: () {},
                                        child: Text(
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
                                              borderRadius: BorderRadius
                                                  .circular(15)),
                                          padding:
                                          EdgeInsets.symmetric(
                                              vertical: 16, horizontal: 121),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 16),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .center,
                                      children: [
                                        Expanded(
                                          child: Reactscontainer(
                                            iconName: Appimages.likes,
                                            NumerOfreacts: movie.likeCount
                                                ?.toDouble() ?? 0,
                                          ),
                                        ),
                                        Expanded(
                                          child: Reactscontainer(
                                            iconName: Appimages.watch,
                                            NumerOfreacts: movie.rating
                                                ?.toDouble() ?? 0,
                                          ),
                                        ),
                                        Expanded(
                                          child: Reactscontainer(
                                            iconName: Appimages.fav,
                                            NumerOfreacts: movie.runtime
                                                ?.toDouble() ?? 0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )

                        , Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Screen Shots",
                                style: TextStyle(
                                  color: Appcolors.whitekColor,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              if (movie.largeScreenshotImage1 != null)
                                Scereenshots(ScreenShotsImage: movie
                                    .largeScreenshotImage1!),
                              if (movie.largeScreenshotImage2 != null)
                                Scereenshots(ScreenShotsImage: movie
                                    .largeScreenshotImage2!),
                              if (movie.largeScreenshotImage3 != null)
                                Scereenshots(ScreenShotsImage: movie
                                    .largeScreenshotImage3!),
                              SizedBox(height: 16),
                              // Similar movies
                              Text(
                                "Similar",
                                style: TextStyle(
                                  color: Appcolors.whitekColor,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(height: 8),

                              FutureBuilder<MovieSuggestionsResponse>(

                                future: ApiManager().getMovieSuggestion(
                                    movieId: widget.movieId),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Center(
                                      child: CircularProgressIndicator(
                                          color: Appcolors.yellowColor),
                                    );
                                  }

                                  if (snapshot.hasError ||
                                      snapshot.data?.data?.movies == null ||
                                      snapshot.data!.data!.movies!.isEmpty) {
                                    return Text("No suggestions available",
                                        style: TextStyle(color: Colors.white));
                                  }

                                  final suggestions = snapshot.data!.data!
                                      .movies!;
                                  final displaySuggestions = suggestions
                                      .length > 4
                                      ? suggestions.sublist(0, 4)
                                      : suggestions;

                                  return GridView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    padding: EdgeInsets.zero,
                                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2, // 2 أعمدة لكل صف
                                      mainAxisSpacing: 12,
                                      crossAxisSpacing: 12,
                                      childAspectRatio: 170 / 240,
                                    ),
                                    itemCount: displaySuggestions.length,
                                    itemBuilder: (context, index) {
                                      final movie = displaySuggestions[index];
                                      return Movieitem(
                                        movies: Movies(
                                          id: movie.id,
                                          mediumCoverImage: movie
                                              .mediumCoverImage,
                                          largeCoverImage: movie
                                              .backgroundImage ?? '',
                                          rating: movie.rating,
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),


                              SizedBox(height: 16),
                              Text(
                                "Summary",
                                style: TextStyle(
                                  color: Appcolors.whitekColor,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(height: 8),


                              Text(
                                description?.isNotEmpty == true
                                    ? description!
                                    : 'No description available',
                                style: TextStyle(
                                  color: Appcolors.whitekColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                                softWrap: true,
                              )
                              ,
                              SizedBox(height: 16),

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
                                          (c) =>
                                          Castcontainer(
                                            CastImage: c.urlSmallImage ??
                                                Appimages.cast1,
                                            CastName: c.name ?? "Unknown",
                                            CharacterName: c.characterName ??
                                                "",
                                          ),
                                    ),
                                  ],
                                ),

                              SizedBox(height: 8),
                              Text(
                                "Genres",
                                style: TextStyle(
                                  color: Appcolors.whitekColor,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(height: 8),
                              Wrap(
                                alignment: WrapAlignment.start,
                                spacing: 16,
                                runSpacing: 11,
                                children: movie.genres!.map((g) =>
                                    Genereitem(Genere: g)).toList(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }

          )

      );
    }
  }

