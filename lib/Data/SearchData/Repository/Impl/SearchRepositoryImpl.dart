import 'package:movieapp/Data/SearchData/DataSources/Remote/SearchRemoteDataSource.dart';
import 'package:movieapp/models/SearchResponse.dart';

import '../SearchRepository.dart';

class Searchrepositoryimpl implements Searchrepository{
final  Searchremotedatasource SearchRemotedatasource;
Searchrepositoryimpl({required this.SearchRemotedatasource});

  @override
  Future<SearchResponse> searchMovies({required String query, int page = 1}) {
return SearchRemotedatasource.searchMovies(query: query);
  }


}