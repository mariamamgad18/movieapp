import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/Api/Api_Manager.dart';
import 'package:movieapp/Data/BrowseData/DataSources/Remote/BrowserRemoteDataSource.dart';
import 'package:movieapp/Data/BrowseData/DataSources/Remote/Impl/BrowserRemoteDataSourceImpl.dart';
import 'package:movieapp/Data/BrowseData/Repository/BrowseRepository.dart';
import 'package:movieapp/Data/BrowseData/Repository/Impl/BrowseRepositoryImpl.dart';
import 'package:movieapp/models/movies_response.dart';
import 'Browse_States.dart';

class BrowseViewModel extends Cubit<BrowseStates> {
  late ApiManager apiManager;
  late Browserremotedatasource browserRemotedatasource;
  late Browserepository browserepository;

  List<Movies> allMovies = [];
  List<String> genres = [];
  String selectedGenre = '';

  BrowseViewModel() : super(BrowseInitialState()) {
    apiManager = ApiManager();
    browserRemotedatasource = Browserremotedatasourceimpl(apiManager: apiManager);
    browserepository = Browserepositoryimpl(browserremotedatasource: browserRemotedatasource);
  }

  Future<void> loadMovies(String initialGenre) async {
    emit(BrowseLoadingState());
    try {
      final response = await browserepository.getAllMovies();
      allMovies = response;

      // استخراج كل الأنواع بدون تكرار
      final Set<String> genreSet = {};
      for (var movie in allMovies) {
        genreSet.addAll(movie.genres ?? []);
      }
      genres = genreSet.toList();

      selectedGenre = initialGenre;

      emit(BrowseSuccessState(
        allMovies: allMovies,
        genres: genres,
        selectedGenre: selectedGenre,
      ));
    } catch (e) {
      emit(BrowseErrorState(errorMsg: e.toString()));
    }
  }

  void changeGenre(String genre) {
    selectedGenre = genre;
    emit(BrowseSuccessState(
      allMovies: allMovies,
      genres: genres,
      selectedGenre: selectedGenre,
    ));
  }
}
