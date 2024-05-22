abstract class AddDoctorState{}
class InitialAddDoctorState extends AddDoctorState{}
class AddDoctorSuccessState extends AddDoctorState{}
class AddDoctorFailedState extends AddDoctorState{}
class ChangeVisablePasswordRegister extends AddDoctorState{}
class ChangeGenderSuccess extends AddDoctorState{}
class LoadingRegisterUserState extends AddDoctorState{}
class RegisterUserError extends AddDoctorState{
  String ?error;
  RegisterUserError(this.error);
}