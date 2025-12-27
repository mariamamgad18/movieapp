import '../../../../models/movies_response.dart';

abstract class Browserremotedatasource {
  Future<List<Movies>> getAllMovies();
}
