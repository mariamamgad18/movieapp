import '../../../../models/MovieDetailsResponse.dart' as details;
import '../../../../models/MovieSuggestion.dart' as sugg;

abstract class Moviedetailsremotedatasource {

  Future<details.Movie> getMovieDetails({required int movieId});
  Future<List<sugg.Movie>> getMovieSuggestions({required int movieId});
  Future<bool> isMovieFavorite({required int movieId});
}