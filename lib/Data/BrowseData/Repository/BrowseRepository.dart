
import '../../../models/movies_response.dart';

abstract class Browserepository {
  Future<List<Movies>> getAllMovies();
}
