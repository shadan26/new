
abstract class DoctorState{}
class InitialDoctorState extends DoctorState{}
class ChangeCurrentIndexState extends DoctorState{}
class GetUserDataSuccess extends DoctorState{}
class GetUserDataError extends DoctorState{
  String ?error;
  GetUserDataError(this.error);
}
class LoadingGetUserData extends DoctorState{}
class ProfileImagePickerSucsess extends DoctorState{}
class ProfileImagePickerError extends DoctorState{}
class ProfileImageUploadSucsess extends DoctorState{}
class ProfileImageUploadrror extends DoctorState{}
class updateUserSuccsesState extends DoctorState{}
class updateUserErrorState extends DoctorState{}
class userUpdateLoadingState extends DoctorState{}
class LoadingGetAllNurses extends DoctorState{}
class GetAllNursesSuccessState extends DoctorState{}
class GetAllNursesFailedState extends DoctorState{}

class GetAllDoctorsSuccess extends DoctorState{}
class GetAllDoctorsError extends DoctorState{
  String ?error;
  GetAllDoctorsError(this.error);
}
class LoadingGetAllDoctors extends DoctorState{}

class LoadingGetAllUsers extends DoctorState{}
class GetAllUsersSuccess extends DoctorState{}
class GetAllUsersError extends DoctorState{
  String ?error;
  GetAllUsersError(this.error);
}

class SendMessageSuccessState extends DoctorState{}
class SendMessageErrorState extends DoctorState{
  String ?error;
  SendMessageErrorState(this.error);

}
class GetMessageSuccessState extends DoctorState{}

class GetAllDoctorHomeScreenTwoSuccess extends DoctorState{}
class GetAllDoctorHomeScreenTwoFailed extends DoctorState{}







//////////////////////////////////////////////////////////


// class ChangeVisablePasswordLogin extends DoctorState{}
// class LoginUserSuccessfully extends DoctorState{
//   String ?uid;
//   LoginUserSuccessfully(this.uid);
// }
// class LoadingLoginUserState extends DoctorState{}
// class LoginUserError extends DoctorState{
//   var error;
//   LoginUserError(error);
// }
// class GetUserDataSuccessLogin extends DoctorState{}
// class GetUserDataErrorLogin extends DoctorState{}
// class LoginUserSuccessfullynew extends DoctorState{}




