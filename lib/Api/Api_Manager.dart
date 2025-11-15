//هنجمع هنا كل الlogic بتاع ال api


import 'package:dio/dio.dart';

import 'ApiEndpoint.dart';
class ApiManager {
//todo : هنعمل obj من Dio
  final dio = Dio();
//هتبقي future , async عشان هنستني الرد من السيرفر قبل ما نكمل أي حاجة

  Future<Response> login({required String email, required String password}) async

  {
    print("Email: $email");
    print("Password: $password");

    try {
      final response = await dio.post(
        // String path, {
        // Object? data,
        // Map<String, dynamic>? queryParameters,
        // Options? options,
        // CancelToken? cancelToken,
        // void Function(int, int)? onSendProgress,
        // void Function(int, int)? onReceiveProgress,
        // }
        Apiendpoint.Url,  //path
        data: { //data
          "email": email,
          "password": password,
        },

        options: Options(  //options
          headers: {'Content-Type': 'application/json'},  //علشان السيرفر يعرف ان البيانات JSON
        ),

      );
      return response;

    }on DioException catch (e){
      if (e.response != null) {   // لو مثلا في ايرور زي مثلا لو الباسوورد غلط
        return e.response!;
      }else {
        throw Exception("Network error: ${e.message}");   // كده ال  e.response ب null يعني مفيش ريسبونس اصلا

      }

    }

  }





}