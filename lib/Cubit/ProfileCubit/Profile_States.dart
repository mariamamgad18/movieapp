import '../../models/GetAllFavoritesMovies.dart';

abstract class ProfileStates {}

class ProfileInitialState extends ProfileStates {}

class ProfileLoadingState extends ProfileStates {}

class ProfileSuccessState extends ProfileStates {
  final List<Data> favorites;
  final int watchListCount;

  ProfileSuccessState({required this.favorites, required this.watchListCount});
}

class ProfileErrorState extends ProfileStates {
  final String errorMsg;

  ProfileErrorState({required this.errorMsg});
}
