import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Api/Api_Manager.dart';
import '../../Data/LoginData/DataSources/Remote/Login_Remote_Data_Source.dart';
import '../../Data/LoginData/DataSources/Remote/impl/Login_Remote_Data_Source_Impl.dart';
import '../../Data/LoginData/Repository/Impl/Login_Repository_impl.dart';
import '../../Data/LoginData/Repository/LoginRepository.dart';
import '../../Utils/UserToken.dart';
import 'LoginStates.dart';

class LoginViewModel extends Cubit<Loginstates> {
  late final ApiManager apiManager;
  late final LoginRemoteDataSource loginRemoteDataSource;
  late final Loginrepository loginrepository;

  LoginViewModel() : super(LoginInitialState()) {
    apiManager = ApiManager();
    loginRemoteDataSource = LoginRemoteDataSourceImpl(apiManager: apiManager);
    loginrepository = LoginRepositoryImpl(loginRemoteDataSource: loginRemoteDataSource);
  }

  Future<void> Login(String email, String password) async {
    emit(LoginLoadingState());
    try {
      var response = await loginrepository.login(email, password);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final msg = response.data['message']?.toString() ?? "";
        final token = response.data['data']?.toString() ?? "";
        if (token.isNotEmpty) {
          await Usertoken.saveToken(token);
        }
        emit(LoginSuccessState(SuccessMessage: msg));
      } else {
        emit(LoginErrorState(ErrorMessage: response.data['message']?.toString()));
      }
    } catch (e) {
      emit(LoginErrorState(ErrorMessage: e.toString()));
    }
  }
}
