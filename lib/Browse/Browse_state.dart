import '../models/movies_response.dart';

class BrowseState {
  final Map<String, List<Movies>> moviesByGenre;
  final List<String> genres;
  final String selectedGenre;
  final List<Movies> filteredMovies;
  final bool isLoading;
  final String? error;

  BrowseState({
    required this.moviesByGenre,
    required this.genres,
    required this.selectedGenre,
    required this.filteredMovies,
    required this.isLoading,
    this.error,
  });

  factory BrowseState.initial() => BrowseState(
    moviesByGenre: {},
    genres: [],
    selectedGenre: "",
    filteredMovies: [],
    isLoading: false,
  );

  BrowseState copyWith({
    Map<String, List<Movies>>? moviesByGenre,
    List<String>? genres,
    String? selectedGenre,
    List<Movies>? filteredMovies,
    bool? isLoading,
    String? error,
  }) {
    return BrowseState(
      moviesByGenre: moviesByGenre ?? this.moviesByGenre,
      genres: genres ?? this.genres,
      selectedGenre: selectedGenre ?? this.selectedGenre,
      filteredMovies: filteredMovies ?? this.filteredMovies,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}
