import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/Api/Api_Manager.dart';
import 'package:movieapp/Data/SearchData/DataSources/Remote/Impl/SearchRemoteDataSourceImpl.dart';
import 'package:movieapp/Data/SearchData/Repository/Impl/SearchRepositoryImpl.dart';

import '../../Data/SearchData/DataSources/Remote/SearchRemoteDataSource.dart';
import '../../Data/SearchData/Repository/SearchRepository.dart';
import 'Search_States.dart';
class Searchviewmodel extends Cubit<SearchStates> {
  late ApiManager apiManager;
  late Searchrepository SearchRepository;
  late Searchremotedatasource SearchRemotedatasource;

  Timer? timer;

  // الكونستركتور بدون أي باراميتر
  Searchviewmodel() : super(SearchInitialState()) {
    apiManager = ApiManager();
    SearchRemotedatasource = Searchremotedatasourceimpl(apiManager: apiManager);
    SearchRepository = Searchrepositoryimpl(SearchRemotedatasource: SearchRemotedatasource);
  }

  void MovieSearch(String query) async {
    if (timer?.isActive ?? false) timer!.cancel();

    timer = Timer(const Duration(milliseconds: 500), () async {
      if (query.isEmpty) {
        emit(SearchEmptyState());
        return;
      }
      emit(SearchLoadingState());

      try {
        final response = await SearchRepository.searchMovies(query: query);
        final movies = response.data?.movies ?? [];

        print(movies); // ده حيطبعلك اللي رجع من الـ API

        if (movies.isEmpty) {
          emit(SearchEmptyState());
        } else {
          emit(SearchSuccessState(searchResults: movies));
        }

      } catch (e) {
        emit(SearchErrorState(errorMsg: e.toString()));
      }
    });
  }

  @override
  Future<void> close() {
    timer?.cancel();
    return super.close();
  }
}
