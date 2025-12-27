
import 'package:movieapp/Data/ProfileData/Repository/ProfileRepository.dart';
import 'package:movieapp/models/GetAllFavoritesMovies.dart';

import '../../DataSource/ProfileRemoteDataSource.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource profileRemoteDataSource;

  ProfileRepositoryImpl({required this.profileRemoteDataSource});

  @override
  Future<GetAllFavoritesMovies> getAllFavoritesMovies() {
    return profileRemoteDataSource.getAllFavoritesMovies();
  }
}
