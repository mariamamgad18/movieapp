// Data/ProfileData/DataSources/Remote/Impl/ProfileRemoteDataSourceImpl.dart

import 'package:dio/dio.dart';
import 'package:movieapp/Api/Api_Manager.dart';
import 'package:movieapp/Utils/UserToken.dart';
import 'package:movieapp/models/GetAllFavoritesMovies.dart';

import '../../../../Api/ApiEndpoint.dart';
import '../ProfileRemoteDataSource.dart';


class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final ApiManager apiManager;

  ProfileRemoteDataSourceImpl({required this.apiManager});

  @override
  Future<GetAllFavoritesMovies> getAllFavoritesMovies() async {
    try {
      final token = await Usertoken.getToken();

      final response = await apiManager.dio.get(
        Apiendpoint.getAllFavoritesMovies,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );

      return GetAllFavoritesMovies.fromJson(response.data);
    } catch (e) {
      return GetAllFavoritesMovies(
        message: "Something went wrong",
        data: [],
      );
    }
  }
}
