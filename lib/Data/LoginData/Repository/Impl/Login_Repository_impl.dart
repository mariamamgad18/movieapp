import 'package:dio/dio.dart';

import '../../DataSources/Remote/Login_Remote_Data_Source.dart';
import '../LoginRepository.dart';

class LoginRepositoryImpl implements Loginrepository{

  //todo : هنعمل obj من ال LoginRemoteDataSource

  LoginRemoteDataSource loginRemoteDataSource;
  LoginRepositoryImpl({
    required this.loginRemoteDataSource
});
  @override
  Future<Response> login(String email,  String password) {
return  loginRemoteDataSource.login(email, password);
  }

}