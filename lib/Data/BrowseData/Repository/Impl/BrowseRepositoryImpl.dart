
import '../../../../models/movies_response.dart';
import '../../DataSources/Remote/BrowserRemoteDataSource.dart';
import '../BrowseRepository.dart';

class Browserepositoryimpl implements Browserepository {
  final Browserremotedatasource browserremotedatasource;

  Browserepositoryimpl({required this.browserremotedatasource});

  @override
  Future<List<Movies>> getAllMovies() {
    return browserremotedatasource.getAllMovies();
  }
}
