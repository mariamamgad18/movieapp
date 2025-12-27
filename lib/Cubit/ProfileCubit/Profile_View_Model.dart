import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/Data/ProfileData/DataSource/Impl/ProfileRemoteDataSourceImpl.dart';
import 'package:movieapp/Data/ProfileData/Repository/Impl/ProfileRepositoryImpl.dart';

import '../../Api/Api_Manager.dart';
import '../../Data/ProfileData/DataSource/ProfileRemoteDataSource.dart';
import '../../Data/ProfileData/Repository/ProfileRepository.dart';
import 'Profile_States.dart';

class ProfileViewModel extends Cubit<ProfileStates> {
  late ApiManager apiManager;
  late ProfileRepository profileRepository;
  late ProfileRemoteDataSource profileRemoteDataSource;

  ProfileViewModel() : super(ProfileInitialState()) {
    apiManager = ApiManager();
    profileRemoteDataSource = ProfileRemoteDataSourceImpl(apiManager: apiManager);
    profileRepository = ProfileRepositoryImpl(profileRemoteDataSource: profileRemoteDataSource);
  }

  Future<void> loadFavorites() async {
    emit(ProfileLoadingState());

    try {
      final response = await profileRepository.getAllFavoritesMovies();
      final favorites = response.data ?? [];

      emit(ProfileSuccessState(
        favorites: favorites,
        watchListCount: favorites.length,
      ));
    } catch (e) {
      emit(ProfileErrorState(errorMsg: e.toString()));
    }
  }
}