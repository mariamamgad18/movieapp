import '../../models/movies_response.dart';

abstract class BrowseStates {}
class BrowseInitialState extends BrowseStates{}
class BrowseLoadingState extends BrowseStates{}

class BrowseSuccessState extends BrowseStates{
  List<Movies> allMovies;
  List<String> genres ;
   String selectedGenre;
  BrowseSuccessState({required this.allMovies,required this.genres,required this.selectedGenre});
}
class BrowseErrorState extends BrowseStates{
   String errorMsg;
   BrowseErrorState({required this.errorMsg});
}
