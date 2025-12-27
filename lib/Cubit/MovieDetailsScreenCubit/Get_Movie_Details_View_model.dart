import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/models/MovieDetailsResponse.dart' as details;
import 'package:movieapp/models/MovieSuggestion.dart' as sugg;

import '../../Api/Api_Manager.dart';
import 'Get_Movie_Details_States.dart';

class GetMovieDetailsViewModel extends Cubit<GetMovieDetailsStates> {
  late ApiManager apiManager;

  GetMovieDetailsViewModel() : super(GetMovieDetailsInitailStates()) {
    apiManager = ApiManager();
  }

  Future<void> getMovieDetails({required int movieId}) async {
    emit(GetMovieDetailsLoadingStates());

    try {
      final movieDetailsResponse =
      await apiManager.getMovieDetails(movieId: movieId);
      final details.Movie movie = movieDetailsResponse.data!.movie!;


      final movieSuggResponse =
      await apiManager.getMovieSuggestion(movieId: movieId);
      final List<sugg.Movie> movieSugg =
          movieSuggResponse.data?.movies ?? [];


      final favResponse = await apiManager.movieIsFavorite(movieId: movieId);
      final bool isMovieSaved = favResponse.data;

      emit(
        GetMovieDetailsSuccessStates(
          movie: movie,
          SuggMovies: movieSugg,
          IsFavorite: isMovieSaved,
          showTrailer: false,
        ),
      );
    } catch (e) {
      emit(GetMovieDetailsErrorStates(ErrorMsg: e.toString()));
    }
  }
}
