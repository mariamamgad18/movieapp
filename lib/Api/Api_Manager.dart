//هنجمع هنا كل الlogic بتاع ال api


import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';

import '../models/MovieDetailsResponse.dart';
import '../models/MovieSuggestion.dart';
import '../models/movies_response.dart';
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
    print("oldPassword: $oldPassword");
    print("newPassword: $newPassword");
    print("confirmPassword: $confirmPassword");
    print("token: $token");

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


  Future<MoviesResponse> getMovies() async {
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

        final moviesResponse = MoviesResponse.fromJson(jsonData);

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

  Future<Map<String, List<Movies>>> getMoviesGroupedByGenre() async {
    // 1. نجيب كل الأفلام
    final moviesResponse = await getMovies();

    // 2. نعمل ليسته من نوع Movies تشيل فيها الأفلام اللي رجعها السيرفر، ولو مفيش حط ليسته فاضية
    final List<Movies> moviesList = moviesResponse.data?.movies ?? [];

    // 3. نعمل ماب تشيل اسم التصنيف والقيمة هي ليسته الأفلام حسب التصنيف
    Map<String, List<Movies>> moviesByGenres = {};

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

}




