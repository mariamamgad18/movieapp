import 'package:movieapp/Api/Api_Manager.dart';
import 'package:movieapp/models/SearchResponse.dart';

import '../SearchRemoteDataSource.dart';

class Searchremotedatasourceimpl implements Searchremotedatasource{
  final ApiManager apiManager;
  Searchremotedatasourceimpl({required this.apiManager});

  @override
  Future<SearchResponse> searchMovies({required String query, int page = 1}) {
final Response = apiManager.searchMovies(query: query);
return Response;
  }

}