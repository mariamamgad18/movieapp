import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInHelper {


  //todo: هنعمل اوبجكت من GoogleSignIn

  static final GoogleSignIn _googleSignIn = GoogleSignIn(
    //todo: يعني مش مطلوب من اليوزر غير الايميل بس
    scopes: ['email'],
    // ممكن نزود سكوبس زي الباسوورد
  );

  static Future<GoogleSignInAccount?> signIn() async {
    try {
      final user = await _googleSignIn.signIn();     // دي بتفتح الويندوز بتاعه جوجل و اليوزر يختار الايميل و يتخزن بياناته ف user
      return user;  //todo: ي اما ترجع بيانات البوزر
    } catch (e) {
      print("Google Sign-In Error: $e");
      return null;   //todo : لو لغي اللويجن مثلا هيرجع null
    }
  }

  static Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
    } catch (e) {
      print("Google Sign-Out Error: $e");
    }
  }
}
