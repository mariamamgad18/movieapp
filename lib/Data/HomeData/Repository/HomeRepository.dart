
import 'package:movieapp/models/movies_response.dart';

abstract class Homerepository {
  Future<List<Movies>> getMovies();
}