import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Api/Api_Manager.dart';
import '../../Data/ProfileData/Repository/ProfileRepository.dart';
import '../../models/GetAllFavoritesMovies.dart' as fav;
import 'FavoriteState.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  final ProfileRepository repository;
  final ApiManager apiManager;

  FavoriteCubit(this.repository, this.apiManager) : super(FavoriteInitial());

  List<fav.Data> favorites = [];

  // تحميل المفضلات من السيرفر أو من SharedPreferences
  Future<void> loadFavorites() async {
    emit(FavoriteLoading());

    final prefs = await SharedPreferences.getInstance();
    final storedFavorites = prefs.getString('favorites');

    if (storedFavorites != null) {
      // لو موجودة في SharedPreferences نقرأها
      final List<dynamic> jsonList = jsonDecode(storedFavorites);
      favorites = jsonList.map((e) => fav.Data.fromJson(e)).toList();
    } else {
      // لو مش موجودة نخزن من السيرفر
      final response = await repository.getAllFavoritesMovies();
      favorites = response.data ?? [];
      // نخزنها محليًا
      await _saveFavoritesLocally();
    }

    emit(FavoriteLoaded(List.from(favorites)));
  }

  Future<void> toggleFavorite({
    required bool isFavorite,
    required fav.Data movieData,
  }) async {
    if (isFavorite) {
      await apiManager.RemoveMovieFromFavorite(movieId: movieData.movieId ?? '');
      favorites.removeWhere((e) => e.movieId == movieData.movieId);
    } else {
      await apiManager.AddMovieToFavorite(
        movieId: movieData.movieId ?? '',
        name: movieData.name ?? '',
        rating: movieData.rating?.toDouble() ?? 0,
        imageURL: movieData.imageURL ?? '',
        year: movieData.year ?? '',
      );
      favorites.add(movieData);
    }

    // تحديث SharedPreferences بعد أي تغيير
    await _saveFavoritesLocally();

    emit(FavoriteLoaded(List.from(favorites)));
  }

  // فحص لو الفيلم موجود في المفضلة
  bool isMovieFavorite(String? movieId) {
    return favorites.any((e) => e.movieId == movieId);
  }

  // دالة لتخزين الليستة محليًا
  Future<void> _saveFavoritesLocally() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = favorites.map((e) => e.toJson()).toList();
    await prefs.setString('favorites', jsonEncode(jsonList));
  }
}
