import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/Api/Api_Manager.dart';
import 'package:movieapp/Data/RegisterData/DataSources/Remote/Register_Remote_Data_Source.dart';
import 'package:movieapp/Data/RegisterData/Repository/Impl/RegisterRepositoryImpl.dart';

import '../../Data/RegisterData/DataSources/Impl/Register_Remote_Data_Souce_Impl.dart';
import '../../Data/RegisterData/Repository/RegisterRepository.dart';
import 'Register_States.dart';

class RegisterViewModel extends Cubit<RegisterStates> {
  late final ApiManager apiManager;
  late final RegisterRemoteDataSource registerRemoteDataSource;
  late final Registerrepository registerRepository;

  RegisterViewModel() : super(ReisterInitialState()) {
    // أولاً نهيئ الـ ApiManager
    apiManager = ApiManager();

    // بعدين نهيئ الـ RemoteDataSource
    registerRemoteDataSource = RegisterRemoteDataSouceImpl(apiManager: apiManager);

    // وأخيرًا نهيئ الـ Repository مع الـ RemoteDataSource الجاهز
    registerRepository = Registerrepositoryimpl(registerRemoteDataSource: registerRemoteDataSource);
  }

  Future<void> Register({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required String phone,
    required int avaterId,
  }) async {
    emit(ReisterLoadingState());
    try {
      final response = await registerRepository.register(
        name: name,
        email: email,
        password: password,
        confirmPassword: confirmPassword,
        phone: phone,
        avaterId: avaterId,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(ReisterSuccessState(
          SuccessMsg: response.data['message'].toString(),
        ));
      } else {
        emit(ReisteErrorState(
          ErrorMsg: response.data['message'].toString(),
        ));
      }
    } catch (e) {
      emit(ReisteErrorState(ErrorMsg: e.toString()));
    }
  }
}
