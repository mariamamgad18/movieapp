import 'package:movieapp/models/movies_response.dart';

import '../../DataSources/Remote/HomeRemoteDataSource.dart';
import '../HomeRepository.dart';

class Homerepositoryimpl implements Homerepository{
  Homeremotedatasource homeRemoteDataSource;
  Homerepositoryimpl({required this.homeRemoteDataSource});

  @override
  Future<List<Movies>> getMovies(){
    return homeRemoteDataSource.getMovies();
  }

}