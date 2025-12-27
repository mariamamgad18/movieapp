import '../../../../models/MovieDetailsResponse.dart' as details;
import '../../../../models/MovieSuggestion.dart' as sugg;
import '../../DataSources/Remote/MovieDetailsRemoteDataSource.dart';
import '../MovieDetailsRepository.dart';

class Moviedetailsrepositoryimpl implements Moviedetailsrepository{
  Moviedetailsremotedatasource moviedetailsRemoteDataSource;

  Moviedetailsrepositoryimpl({
    required this.moviedetailsRemoteDataSource
});
  @override
  Future<details.Movie> getMovieDetails({required int movieId}){
    return  moviedetailsRemoteDataSource.getMovieDetails(movieId: movieId);
  }
  @override

  Future<List<sugg.Movie>> getMovieSuggestions({required int movieId}) {
    return moviedetailsRemoteDataSource.getMovieSuggestions(movieId: movieId);
  }

  @override
  Future<bool> isMovieFavorite({required int movieId}){
    return  moviedetailsRemoteDataSource.isMovieFavorite(movieId: movieId);

  }
}