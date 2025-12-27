import 'package:movieapp/models/movies_response.dart';


abstract class Homeremotedatasource {
  Future<List<Movies>> getMovies();
}