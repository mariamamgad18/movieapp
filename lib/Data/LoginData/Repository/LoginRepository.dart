import 'package:dio/dio.dart';

abstract class Loginrepository {
  Future<Response> login(String email,  String password);

}