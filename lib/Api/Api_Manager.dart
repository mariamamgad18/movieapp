import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';

import '../Utils/UserToken.dart';
import '../models/AddMovieToFav.dart';
import '../models/DeleteProfile.dart';
import '../models/GetAllFavoritesMovies.dart';
import '../models/MovieDetailsResponse.dart';
import '../models/MovieIsFavorite.dart';
import '../models/MovieSuggestion.dart';
import '../models/Profile_Response.dart';
import '../models/RemoveMovie.dart';
import '../models/SearchResponse.dart' as search_model;
import '../models/UpdateProfile.dart';
import '../models/movies_response.dart' as movies_model;
import 'ApiEndpoint.dart';
class ApiManager {
//todo : هنعمل obj من Dio
  final dio = Dio();

  Future<Response> login(
      {required String email, required String password}) async

  {
    print("Email: $email");
    print("Password: $password");

    try {
      final response = await dio.post(
        // String path, {
        // Object? data,
        // Map<String, dynamic>? queryParameters,
        // Options? options,
        // CancelToken? cancelToken,
        // void Function(int, int)? onSendProgress,
        // void Function(int, int)? onReceiveProgress,
        // }
        Apiendpoint.LoginUrl, //path
        data: { //data
          "email": email,
          "password": password,
        },

        options: Options( //options
          headers: {
            'Content-Type': 'application/json'
          }, //علشان السيرفر يعرف ان البيانات JSON
        ),

      );
      return response;
    } on DioException catch (e) {
      if (e.response != null) { // لو مثلا في ايرور زي مثلا لو الباسوورد غلط
        return e.response!;
      } else {
        throw Exception("Network error: ${e
            .message}"); // كده ال  e.response ب nFuture<Response>ش ريسبونس اصلا

      }
    }
  }


  Future<Response> register({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required String phone,
    required int avaterId,
  }) async {
    print("name: $name");
    print("email: $email");
    print("password: $password");
    print("confirmPassword: $confirmPassword");
    print("phone: $phone");
    print("avaterId: $avaterId");
    try {
      final response = await dio.post(

        Apiendpoint.RrgisterUrl,
        //path
        data: { //data
          "name": name,
          "email": email,
          "password": password,
          "confirmPassword": confirmPassword,
          "phone": phone,
          "avaterId": avaterId,

        },
        options: Options( //options
          headers: {
            'Content-Type': 'application/json'
          }, //علشان السيرفر يعرف ان البيانات JSON
        ),

      );
      return response;
    }
    on DioException catch (e) {
      if (e.response != null) { // لو مثلا في ايرور زي مثلا لو الباسوورد غلط
        return e.response!;
      } else {
        throw Exception("Network error: ${e
            .message}"); // كده ال  e.response ب nFuture<Response>ش ريسبونس اصلا

      }
    }
  }



  Future<Response> ChangePassword({
    required String oldPassword,
    required String newPassword,
    required String confirmPassword,
    required String token,
  }) async {

    try {
      final response = await dio.patch(
        Apiendpoint.ResetPassUrl,
        data: {
          "oldPassword": oldPassword,
          "newPassword": newPassword,
          "confirmPassword": confirmPassword,
        },
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          },
        ),
      );

      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        return e.response!;
      } else {
        throw Exception("Network error: ${e.message}");
      }
    }
  }



  Future<movies_model.MoviesResponse> getMovies() async {
    try {
      final response = await dio.get(Apiendpoint.MoviesUrl);

      if (response.statusCode == 200) {
        dynamic jsonData;

        // لو رجع String → حوله JSON
        if (response.data is String) {
          jsonData = jsonDecode(response.data);
        } else {
          jsonData = response.data;
        }

        final moviesResponse = movies_model.MoviesResponse.fromJson(jsonData);

        if (moviesResponse.status == "ok") {
          return moviesResponse;
        } else {
          throw Exception("API error: ${moviesResponse.statusMessage}");
        }
      } else {
        throw Exception("Server returned status code ${response.statusCode}");
      }
    } on DioException catch (e) {
      throw Exception("Network error: ${e.message}");
    } catch (e) {
      throw Exception("Parsing error: $e");
    }
  }




//todo: الفانكشن المسؤوله عن تصنيف الافلام ف الهوم بيدج
  //الفانكشن المفروض ترجعلي ماب  movies  , ال key هو اسم التصنيف و الvalue هي الليسته نفسها

  Future<Map<String, List<movies_model.Movies>>> getMoviesGroupedByGenre() async {
    // 1. نجيب كل الأفلام
    final moviesResponse = await getMovies();

    // 2. نعمل ليسته من نوع Movies تشيل فيها الأفلام اللي رجعها السيرفر، ولو مفيش حط ليسته فاضية
    final List<movies_model.Movies> moviesList = moviesResponse.data?.movies ?? [];

    // 3. نعمل ماب تشيل اسم التصنيف والقيمة هي ليسته الأفلام حسب التصنيف
    Map<String, List<movies_model.Movies>> moviesByGenres = {};

    // 4. الفور لوب عشان تعدي على كل فيلم
    for (var movie in moviesList) {
      if (movie.genres != null) {
        for (var genre in movie.genres!) {
          // لو التصنيف ده مش موجود في الماب نضيفه
          if (!moviesByGenres.containsKey(genre)) {
            moviesByGenres[genre] = [];
          }
          // نضيف الفيلم للنوع ده
          moviesByGenres[genre]!.add(movie);
        }
      }
    }

    // 5. نرجع الماب
    return moviesByGenres;
  }



  Future<MovieDetailsResponse> getMovieDetails({required int movieId}) async {
    try {
      final url = "${Apiendpoint.MovieDetails}?movie_id=$movieId&with_images=true&with_cast=true";
      final response = await dio.get(url);

      if (response.statusCode == 200) {
        dynamic jsonData;

        // لو رجع String → حوله JSON
        if (response.data is String) {
          jsonData = jsonDecode(response.data);
        } else {
          jsonData = response.data;
        }

        final movieDetails = MovieDetailsResponse.fromJson(jsonData);

        if (movieDetails.status == "ok") {
          return movieDetails;
        } else {
          throw Exception("API error: ${movieDetails.statusMessage}");
        }
      } else {
        throw Exception("Server returned status code ${response.statusCode}");
      }
    } on DioException catch (e) {
      throw Exception("Network error: ${e.message}");
    } catch (e) {
      throw Exception("Parsing error: $e");
    }
  }

  Future<MovieSuggestionsResponse> getMovieSuggestion({required int movieId}) async {
    try {
      final url = "${Apiendpoint.MovieSuggestion}?movie_id=$movieId";
      final response = await dio.get(url);

      if (response.statusCode == 200) {
        dynamic jsonData;

        // لو رجع String → حوله JSON
        if (response.data is String) {
          jsonData = jsonDecode(response.data);
        } else {
          jsonData = response.data;
        }

        final MovieSuggestion = MovieSuggestionsResponse.fromJson(jsonData);

        if (MovieSuggestion.status == "ok") {
          return MovieSuggestion;
        } else {
          throw Exception("API error: ${MovieSuggestion.statusMessage}");
        }
      } else {
        throw Exception("Server returned status code ${response.statusCode}");
      }
    } on DioException catch (e) {
      throw Exception("Network error: ${e.message}");
    } catch (e) {
      throw Exception("Parsing error: $e");
    }
  }



  Future<search_model.SearchResponse> searchMovies({required String query, int page = 1}) async {
    try {
      final response = await dio.get(
        Apiendpoint.SearchUrl,
        queryParameters: {
          "query_term": query.trim(),
          "page": page,
        },
        options: Options(
          headers: {
            "Content-Type": "application/json",
          },
        ),
      );

      if (response.statusCode == 200) {
        dynamic jsonData = response.data;
        if (jsonData is String) {
          jsonData = jsonDecode(jsonData);
        }

        final searchResponse = search_model.SearchResponse.fromJson(jsonData);

        if (searchResponse.status == "ok") {
          return searchResponse;
        } else {
          throw Exception("API error: ${searchResponse.statusMessage}");
        }
      } else {
        throw Exception("Server returned status code ${response.statusCode}");
      }
    } on DioException catch (e) {
      throw Exception("Network error: ${e.message}");
    } catch (e) {
      throw Exception("Parsing error: $e");
    }
  }

  Future<ProfileResponse> getProfile() async {
    try {
      final token = await Usertoken.getToken();

      if (token == null) {
        throw Exception("No token saved");
      }

      final response = await dio.get(
        Apiendpoint.ProfileUrl,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );

      return ProfileResponse.fromJson(response.data);

    } on DioException catch (e) {
      throw Exception("Network error: ${e.message}");
    } catch (e) {
      throw Exception("Parsing error: $e");
    }
  }

  Future<UpdateProfile> updateProfile(Map<String, dynamic> body) async {
    try {
      final token = await Usertoken.getToken();
      if (token == null) throw Exception("No token saved");

      final response = await dio.patch(
        Apiendpoint.ProfileUrl,
        data: body,
        options: Options(
          headers: {"Authorization": "Bearer $token"},
        ),
      );

      return UpdateProfile.fromJson(response.data);

    } on DioException catch (e) {
      throw Exception("Network error: ${e.message}");
    } catch (e) {
      throw Exception("Parsing error: $e");
    }
  }

  Future<DeleteProfile> deleteProfile() async {
    try {
      final token = await Usertoken.getToken();
      if (token == null) throw Exception("No token saved");

      final response = await dio.delete(
        Apiendpoint.ProfileUrl,
        options: Options(
          headers: {"Authorization": "Bearer $token"},
        ),
      );

      return DeleteProfile.fromJson(response.data);

    } on DioException catch (e) {
      throw Exception("Network error: ${e.message}");
    } catch (e) {
      throw Exception("Parsing error: $e");
    }
  }



//todo : دي وظيفتها انها تاخد بيانات الفيلم تبعتها للسيرفر
  /*
  movieId (string) - The ID of the movie to be added to favorites.

name (string) - The name of the movie.

rating (number) - The rating of the movie.

imageURL (string) - The URL of the movie's image.

year (string) - The release year of the movie.*/
  Future<AddMovieToFav> AddMovieToFavorite({required String movieId , required String name , required double rating , required String imageURL , required String year ,
  }) async{
    try {
      final token = await Usertoken.getToken();
      final response = await dio.post(
          Apiendpoint.addMovieToFavorite, data: {
        "movieId": movieId,
        "name": name,
        "rating": rating,
        "imageURL": imageURL,
        "year": year,
      },
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Content-Type": "application/json",
          }
        )
      );
      return AddMovieToFav.fromJson(response.data);
    }catch(e){
      return AddMovieToFav(
        message: ["Something went wrong"],
        error: e.toString(),
        statusCode: 500,
      );
    }
  }




  Future<GetAllFavoritesMovies> getAllFavoritesMovies() async {
try{

  final token = await Usertoken.getToken();
  final response = await dio.get(
      Apiendpoint.getAllFavoritesMovies,
    options: Options(
      headers: {
        "Authorization": "Bearer $token",

      }
    )
  );

  return GetAllFavoritesMovies.fromJson(response.data);

}catch(e){

  return GetAllFavoritesMovies(
    message: "Something went wrong",
    data: [],
  );
}
  }

//هنعمل فانكشن تتشيك ازا كان الفيلم محطوط في الفيوفريت ولا لا
Future<MovieIsFavorite>movieIsFavorite({required int movieId})async{
try{
  final token = await Usertoken.getToken();
  if(token==null){
    //لو مفيش توكين يعني اليوزر مش عامل لوج ان
    throw Exception("no user !");
  }
  final response = await dio.get(
    //هنتشيك ع الفيلم بناء بال id بتاعه
    "${Apiendpoint.movieIsFavorite}/$movieId",
    options: Options(
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      }
    )
  );
  return MovieIsFavorite.fromJson(response.data);

}catch(e){
  return MovieIsFavorite(
    message: "Something went wrong",
    data: false,
  );
}
}


  Future<RemoveMovie>RemoveMovieFromFavorite({required String movieId})async{
    try{
      final token = await Usertoken.getToken();
      if(token==null){
        //لو مفيش توكين يعني اليوزر مش عامل لوج ان
        throw Exception("no user !");
      }
      final response = await dio.delete(
        //هنتشيك ع الفيلم بناء بال id بتاعه
          "${Apiendpoint.removeMovie}/$movieId",
          options: Options(
              headers: {
                "Authorization": "Bearer $token",
                "Content-Type": "application/json",
              }
          )
      );
      return RemoveMovie.fromJson(response.data);

    }catch(e){
      return RemoveMovie(
        message: "Something went wrong",
        statusCode: 500,
      );
    }
  }




}




