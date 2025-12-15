
class Apiendpoint {
  static String LoginUrl = "https://route-movie-apis.vercel.app/auth/login";
  static String RrgisterUrl = "https://route-movie-apis.vercel.app/auth/register";
  static String ResetPassUrl = "https://route-movie-apis.vercel.app/auth/reset-password";

  //phase 3
  static String MoviesUrl = "https://yts.lt/api/v2/list_movies.json";
  static String MovieDetails = "https://yts.lt/api/v2/movie_details.json";
  static String MovieSuggestion = "https://yts.lt/api/v2/movie_suggestions.json";

  //phase 4
  static String SearchUrl = "https://yts.lt/api/v2/list_movies.json";
  static String ProfileUrl = "https://route-movie-apis.vercel.app/profile";

  // Favorites
  static String addMovieToFavorite = "https://route-movie-apis.vercel.app/favorites/add";
  static String getAllFavoritesMovies = "https://route-movie-apis.vercel.app/favorites/all";
  static String removeMovie = "https://route-movie-apis.vercel.app/favorites/remove"; // + movieId
  static String movieIsFavorite = "https://route-movie-apis.vercel.app/favorites/is-favorite"; // + movieId

}