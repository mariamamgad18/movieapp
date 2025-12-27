import 'package:movieapp/Api/Api_Manager.dart';

import '../../../../../models/MovieDetailsResponse.dart' as details;
import '../../../../../models/MovieSuggestion.dart' as sugg;
import '../MovieDetailsRemoteDataSource.dart';

class MovieDetailsRemoteDataSourceImpl implements Moviedetailsremotedatasource {
  final ApiManager apiManager;

  MovieDetailsRemoteDataSourceImpl({required this.apiManager});

  @override
  Future<details.Movie> getMovieDetails({required int movieId}) async {
    final getMovieDetailsResponse = await apiManager.getMovieDetails(movieId: movieId);
    return getMovieDetailsResponse.data!.movie!;
  }

  @override
  Future<List<sugg.Movie>> getMovieSuggestions({required int movieId}) async {
    final getMovieSuggestionsResponse = await apiManager.getMovieSuggestion(movieId: movieId);
    return getMovieSuggestionsResponse.data?.movies ?? [];
  }

  @override
  Future<bool> isMovieFavorite({required int movieId}) async {
    final isMovieFavoriteResponse = await apiManager.movieIsFavorite(movieId: movieId);
    return isMovieFavoriteResponse.data;
  }
}
