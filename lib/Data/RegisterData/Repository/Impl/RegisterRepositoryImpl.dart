import 'package:dio/dio.dart';
import 'package:movieapp/Data/RegisterData/Repository/RegisterRepository.dart';

import '../../DataSources/Remote/Register_Remote_Data_Source.dart';

class Registerrepositoryimpl implements Registerrepository{
  //todo: هنعمل اوبجكت من RegisterRemoteDataSource
  RegisterRemoteDataSource registerRemoteDataSource;
  //todo : و نبعته  ف الكونستراكتور

  Registerrepositoryimpl({
    required this.registerRemoteDataSource
});

  @override
  Future<Response> register({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required String phone,
    required int avaterId,
  }){
    return registerRemoteDataSource.register(name: name,
        email: email,
        password: password,
        confirmPassword: confirmPassword,
        phone: phone,
        avaterId: avaterId);
  }
}