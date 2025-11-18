import 'package:shared_preferences/shared_preferences.dart';
class Usertoken {
  static  Future<void> saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userToken', token);
  }

}

// ال Token :
// هو رقم او كود ال Api بيديه لليوزر
//  عشان بعد كده لو حب يعمل ريكويست يكون مسموحله ياخد بيانات
//لما اليوزر يعمل لوج ان ويتم بنجاح السيرفر بيرجعله Token
// لما بعد كده يعمي ريكويست مثلا بتغيير بيانات او تحديث بروفايل بيحتاج التوكين ك دليل انه مسموحله يستخدم ال Api