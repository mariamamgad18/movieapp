import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Api/Api_Manager.dart';
import '../../Data/HomeData/DataSources/Remote/HomeRemoteDataSource.dart';
import '../../Data/HomeData/DataSources/Remote/Impl/HomeRemoteDataSourceImpl.dart';
import '../../Data/HomeData/Repository/HomeRepository.dart';
import '../../Data/HomeData/Repository/Impl/HomeRepositoryImpl.dart';
import 'Home_Screen_States.dart';

class HomeScreenViewModel extends Cubit<HomeScreenStates> {
  late final ApiManager apiManager;
  late final Homeremotedatasource homeremotedatasource;
  late final Homerepository homerepository;

  HomeScreenViewModel() : super(HomeInitialState()) {
    apiManager = ApiManager();
    homeremotedatasource = Homeremotedatasourceimpl(apiManager: apiManager);
    homerepository = Homerepositoryimpl(homeRemoteDataSource: homeremotedatasource);
  }

  Future<void> getMovies() async {
    emit(HomeLoadingState());
    try {
      final allMovies = await homerepository.getMovies();
      final groupedMovies = await apiManager.getMoviesGroupedByGenre();
      emit(HomeSuccessState(allMovies: allMovies, groupedMovies: groupedMovies));
    } catch (e) {
      emit(HomeErrorState(errorMsg: e.toString()));
    }
  }
}
