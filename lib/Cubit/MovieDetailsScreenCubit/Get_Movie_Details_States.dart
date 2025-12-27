import 'package:movieapp/models/MovieDetailsResponse.dart' as details;
import 'package:movieapp/models/MovieSuggestion.dart' as sugg;

abstract class GetMovieDetailsStates {}

class GetMovieDetailsInitailStates extends GetMovieDetailsStates {}

class GetMovieDetailsLoadingStates extends GetMovieDetailsStates {}

class GetMovieDetailsSuccessStates extends GetMovieDetailsStates {
  final details.Movie movie;
  final List<sugg.Movie> SuggMovies;

  final bool IsFavorite;
  final bool showTrailer;

  GetMovieDetailsSuccessStates({
    required this.movie,
    required this.SuggMovies,
    required this.IsFavorite,
    required this.showTrailer,
  });
}

class GetMovieDetailsErrorStates extends GetMovieDetailsStates {
  final String ErrorMsg;
  GetMovieDetailsErrorStates({required this.ErrorMsg});
}
