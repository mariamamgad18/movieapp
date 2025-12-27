abstract class RegisterStates {}
class ReisterInitialState extends RegisterStates{}
class ReisterLoadingState extends RegisterStates{}
class ReisteErrorState extends RegisterStates{
  String ?ErrorMsg;
  ReisteErrorState({
    required this.ErrorMsg
  });
}
class ReisterSuccessState extends RegisterStates{
  String ?SuccessMsg;
  ReisterSuccessState({
    required this.SuccessMsg
});
}