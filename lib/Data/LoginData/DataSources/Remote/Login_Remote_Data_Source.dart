import 'package:dio/dio.dart';

abstract class LoginRemoteDataSource {

  Future<Response> login(String email,  String password);

}