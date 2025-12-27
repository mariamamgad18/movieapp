import 'package:dio/dio.dart';

abstract class RegisterRemoteDataSource {
  Future<Response> register({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required String phone,
    required int avaterId,
  });


}