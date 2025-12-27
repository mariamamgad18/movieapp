import 'package:movieapp/Api/Api_Manager.dart';

import '../../../../../models/movies_response.dart';
import '../HomeRemoteDataSource.dart';

class Homeremotedatasourceimpl implements Homeremotedatasource {
  final ApiManager apiManager;

  Homeremotedatasourceimpl({required this.apiManager});

  @override
  Future<List<Movies>> getMovies() async {
    final HomeResponse = await apiManager.getMovies();
    return HomeResponse.data?.movies ?? [];
  }
}
