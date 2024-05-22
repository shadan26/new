 abstract class LoginState{}
 class InitialLoginState extends LoginState{}
 class ChangeVisablePasswordLogin extends LoginState{}
 class LoginUserSuccessfully extends LoginState{
    String ?uid;
   LoginUserSuccessfully(this.uid);
 }
 class LoadingLoginUserState extends LoginState{}
 class LoginUserError extends LoginState{
   var error;
   LoginUserError(error);
 }
 class GetUserDataSuccessLogin extends LoginState{}
 class GetUserDataErrorLogin extends LoginState{}
 class ChangeRoleState extends LoginState{}



 class LoginDoctorSuccessfully extends LoginState{
   String ?uid;
   LoginDoctorSuccessfully(this.uid);
 }
 class LoadingLoginDoctorState extends LoginState{}
 class LoginDoctorError extends LoginState{
   var error;
   LoginDoctorError(error);
 }