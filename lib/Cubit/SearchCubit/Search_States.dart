import '../../models/SearchResponse.dart' as search_model;

abstract class SearchStates {}
class SearchInitialState extends SearchStates{}
class SearchLoadingState extends SearchStates{}

class SearchSuccessState extends SearchStates{
  final List<search_model.SearchMovie>searchResults ;
  SearchSuccessState({required this.searchResults});
  }

//يعني في ريسبونس بس مفيش نتيجه يعني مفيش فيلم
class SearchEmptyState extends SearchStates {
}

class SearchErrorState extends SearchStates{
  String errorMsg;
  SearchErrorState({required this.errorMsg});
}
