

import '../../../models/GetAllFavoritesMovies.dart';

abstract class ProfileRemoteDataSource {
  Future<GetAllFavoritesMovies> getAllFavoritesMovies();
}
