import 'package:movieapp/Api/Api_Manager.dart';

import '../../../../../models/movies_response.dart';
import '../BrowserRemoteDataSource.dart';

class Browserremotedatasourceimpl implements Browserremotedatasource {
  final ApiManager apiManager;

  Browserremotedatasourceimpl({required this.apiManager});

  @override
  Future<List<Movies>> getAllMovies() async {
    final response = await apiManager.getMovies();
    return response.data?.movies ?? [];
  }
}
