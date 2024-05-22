import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:doctorproject/7doctor/cubit/cubit.dart';
import 'package:doctorproject/7doctor/cubit/state.dart';
import 'package:doctorproject/7doctor/homescreen/homescreen.dart';
import 'package:doctorproject/7doctor/homescreen/homescreentwo.dart';
import 'package:doctorproject/7doctor/moduels/loginmodel/logincubit/cubit.dart';
import 'package:doctorproject/7doctor/moduels/loginmodel/logincubit/state.dart';
import 'package:doctorproject/7doctor/moduels/registermodel/registerscreen.dart';
import 'package:doctorproject/shared/constants/constants.dart';
import 'package:doctorproject/shared/shared_preferense/sharedPreferense.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatelessWidget{
  var emailController=TextEditingController();
  var PasswordController=TextEditingController();
  var formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit,LoginState>(
          listener: (context,LoginState){
            if(LoginState is LoginUserError){
              Fluttertoast.showToast(
                  msg: "Login failed. Please check your credentials and try again.",
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.blue,
                  textColor: Colors.white,
                  fontSize: 16.0
              );
            }
            if(LoginState is LoginUserSuccessfully){
              Fluttertoast.showToast(
                  msg: "Login Success",
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.blue,
                  textColor: Colors.white,
                  fontSize: 16.0
              );
               SharedHelper.SaveData(
                   key: 'uid', value:LoginState.uid).then((value) {
                     Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomeScreenTwo()), (route) => false);


               });
              //Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomeScreen()), (route) => false);


            }
            if(LoginState is LoginDoctorSuccessfully){
              Fluttertoast.showToast(
                  msg: "Login Success",
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.blue,
                  textColor: Colors.white,
                  fontSize: 16.0
              );
              SharedHelper.SaveData(
                  key: 'uid', value:LoginState.uid).then((value) {
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomeScreenTwo()), (route) => false);


              });


            }
            if(LoginState is LoginDoctorError){
              Fluttertoast.showToast(
                  msg: "Login failed. Please check your credentials and try again.",
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.blue,
                  textColor: Colors.white,
                  fontSize: 16.0
              );
            }
          },
          builder: (context,DoctorState){
            LoginCubit cubit=LoginCubit.get(context);

            return  ConditionalBuilder(
                condition: DoctorState is! LoadingGetUserData,
                builder: (context)=>Scaffold(
                  backgroundColor: Colors.white,
                  appBar: AppBar(
                    backgroundColor: Colors.white,
                    elevation: 0,
                    systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarColor: Colors.white,
                        statusBarIconBrightness: Brightness.dark
                    ),

                  ),
                  body: Center(
                    child: SingleChildScrollView(
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsetsDirectional.all(20),
                        child: Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'LOGIN',
                                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                'Login now to chat and communicate with doctors',
                                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                    color: Colors.grey
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                    label: Text(
                                      'Email Address',

                                    ),
                                    border: OutlineInputBorder(),
                                    prefixIcon: Icon(
                                        Icons.email_outlined
                                    )
                                ),
                                keyboardType: TextInputType.emailAddress,
                                controller:emailController,
                                validator: (String ?value){
                                  if(value==null || value.isEmpty){
                                    return 'please enter your email';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                    label: Text(
                                      'Password',

                                    ),
                                    border: OutlineInputBorder(),
                                    prefixIcon: Icon(
                                        Icons.lock
                                    ),
                                    suffixIcon:IconButton(
                                      onPressed: (){
                                        cubit.ChangeVisable();
                                      },
                                      icon: Icon(
                                          cubit.visableIcon

                                      ),
                                    )
                                ),
                                keyboardType: TextInputType.emailAddress,
                                obscureText:cubit.isVisable,
                                controller:PasswordController,
                                validator: (String ?value){
                                  if(value==null || value.isEmpty){
                                    return 'please enter your password';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 30,
                              ),

                              ConditionalBuilder(
                                condition:DoctorState is!LoadingLoginUserState ,
                                builder: (context)=>Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: Colors.blue[800],
                                      borderRadius: BorderRadiusDirectional.circular(20)
                                  ),
                                  child: MaterialButton(
                                    onPressed: (){
                                      if(formKey.currentState!.validate()){
                                        if(cubit.selectedRole=='User') {
                                          cubit.LoginUserData(context,
                                              email: emailController.text,
                                              password: PasswordController
                                                  .text);
                                        }
                                        else if(cubit.selectedRole=='Doctor'){
                                          cubit.LoginDoctorData(context,
                                              email: emailController.text,
                                              password: PasswordController
                                                  .text);

                                        }

                                      }

                                    },
                                    child: Text(
                                      'LOGIN',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),

                                  ),
                                ),
                                fallback:(context)=>Center(child: CircularProgressIndicator()) ,
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Don\'t have an account ?',
                                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 17
                                    ),
                                  ),
                                  TextButton(onPressed: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterScreen()));
                                  }
                                      , child: Text(
                                        'REGISTER',
                                        style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                            color: Colors.blue[800],
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15
                                        ),
                                      ))
                                ],
                              )





                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                fallback: (context)=>Center(child: CircularProgressIndicator()));
          },


      );

  }


}
