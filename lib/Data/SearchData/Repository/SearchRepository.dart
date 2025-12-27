import '../../../models/SearchResponse.dart' as search_model;

abstract class Searchrepository {
  Future<search_model.SearchResponse> searchMovies({required String query, int page = 1});
}