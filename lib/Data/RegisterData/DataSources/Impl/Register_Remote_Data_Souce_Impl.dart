 import 'package:dio/dio.dart';
import 'package:movieapp/Api/Api_Manager.dart';
import 'package:movieapp/Data/RegisterData/DataSources/Remote/Register_Remote_Data_Source.dart';

class RegisterRemoteDataSouceImpl implements RegisterRemoteDataSource{
 //todo : عشان استخدم فانكشن الريجستر لازم اعمل اوبجكت من ApiManager

  ApiManager apiManager;

  RegisterRemoteDataSouceImpl({
    required this.apiManager
});

  @override
  Future<Response> register({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required String phone,
    required int avaterId,
  })async{
    var RegisterResponse = await apiManager.register(name: name, email: email, password: password, confirmPassword: confirmPassword, phone: phone, avaterId: avaterId);
    return RegisterResponse;
  }
}