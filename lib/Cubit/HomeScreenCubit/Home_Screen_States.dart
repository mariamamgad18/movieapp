import '../../models/movies_response.dart';

abstract class HomeScreenStates {}

class HomeInitialState extends HomeScreenStates {}

class HomeLoadingState extends HomeScreenStates {}

class HomeSuccessState extends HomeScreenStates {
  final List<Movies> allMovies;
  final Map<String, List<Movies>> groupedMovies;

  HomeSuccessState({required this.allMovies, required this.groupedMovies});
}

class HomeErrorState extends HomeScreenStates {
  final String errorMsg;

  HomeErrorState({required this.errorMsg});
}
