abstract class Loginstates {}
class LoginInitialState extends Loginstates{}

class LoginLoadingState extends Loginstates{}

class LoginSuccessState extends Loginstates{
  String ?SuccessMessage;
  LoginSuccessState(
  {
    required this.SuccessMessage
}
      );
}

class LoginErrorState extends Loginstates{
  String ?ErrorMessage;
  LoginErrorState(
  {
    required this.ErrorMessage
}
      );
}