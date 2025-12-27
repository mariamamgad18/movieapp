

import '../../../models/GetAllFavoritesMovies.dart';

abstract class ProfileRepository {
  Future<GetAllFavoritesMovies> getAllFavoritesMovies();
}
