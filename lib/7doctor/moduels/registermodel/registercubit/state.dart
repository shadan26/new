abstract class RegisterState{}
class InitailRegisterState extends RegisterState{}
class ChangeVisablePasswordRegister extends RegisterState{}
class RegisterUserSuccessfully extends RegisterState{}
class LoadingRegisterUserState extends RegisterState{}
class RegisterUserError extends RegisterState{
   var error;
   RegisterUserError(error);
}
class CreateUserSuccessState extends RegisterState{}
class CreaterUserErrorState extends RegisterState{
   var error;
   CreaterUserErrorState(error);
}
class GetUserDataSuccessRegister extends RegisterState{}
class GetUserDataErrorRegister extends RegisterState{}
class ChangeGenderSuccess extends RegisterState{}
class ChangeGenderError extends RegisterState{}




