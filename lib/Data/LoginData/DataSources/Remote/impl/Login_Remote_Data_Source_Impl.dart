import 'package:dio/dio.dart';

import '../../../../../Api/Api_Manager.dart';
import '../Login_Remote_Data_Source.dart';

class LoginRemoteDataSourceImpl implements LoginRemoteDataSource{
  //todo: بدل م اخد الفانكشن كوبي هستدعيها من ال ApiManager
  //todo : هعمل obj من ال ApiManager

  ApiManager apiManager;
  LoginRemoteDataSourceImpl(
      {
    required this.apiManager
}
      );
  @override
  Future<Response> login(String email,  String password)async{
var LoginResponse = await apiManager.login(email: email, password: password);
return LoginResponse;
  }

}