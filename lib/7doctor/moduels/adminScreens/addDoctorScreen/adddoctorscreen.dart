import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:doctorproject/7doctor/cubit/cubit.dart';
import 'package:doctorproject/7doctor/moduels/adminScreens/addDoctorScreen/cubit.dart';
import 'package:doctorproject/7doctor/moduels/adminScreens/addDoctorScreen/state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddDoctorScreen extends StatelessWidget{
  @override
  var userNameController=TextEditingController();
  var emailAddressController=TextEditingController();
  var passswordController=TextEditingController();
  var phoneController=TextEditingController();
  var majorController=TextEditingController();
  var cvController=TextEditingController();
  var formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>AddDoctorCubit(),
      child: BlocConsumer<AddDoctorCubit,AddDoctorState>(
        listener: (context,AddDoctorState){
          if(AddDoctorState is AddDoctorSuccessState){
            Fluttertoast.showToast(
                msg: "Created Successfully",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.blue,
                textColor: Colors.white,
                fontSize: 16.0
            );
          }
          if(AddDoctorState is AddDoctorFailedState)
          {
            Fluttertoast.showToast(
                msg: "There is An error",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.blue,
                textColor: Colors.white,
                fontSize: 16.0
            );
          }
        },
        builder: (context,AddDoctorState){
          var cubit=AddDoctorCubit.get(context);
          return Container(
              width: double.infinity,
              padding: EdgeInsetsDirectional.all(20),
              child: Center(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Enter the doctor Information',
                          style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            fontSize: 30
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              label: Text(
                                'User Name',

                              ),
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(
                                  Icons.person
                              )
                          ),
                          keyboardType: TextInputType.text,
                          controller:userNameController,
                          validator: (String ?value){
                            if(value==null || value.isEmpty){
                              return 'please enter your name';
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
                                'Email Address',

                              ),
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(
                                  Icons.email_outlined
                              )
                          ),
                          keyboardType: TextInputType.emailAddress,
                          controller:emailAddressController,
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
                              suffixIcon:IconButton(
                                onPressed: (){
                                  cubit.ChangeVisable();
                                },
                                icon: Icon(
                                    cubit.visableIcon


                                ),
                              ) ,
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(
                                  Icons.lock
                              )
                          ),
                          obscureText: cubit.isVisable,
                          keyboardType: TextInputType.text,
                          controller:passswordController,
                          validator: (String ?value){
                            if(value==null || value.isEmpty){
                              return 'please enter your password (1-7 character)';
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
                                'Phone',

                              ),
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(
                                  Icons.phone
                              )
                          ),
                          keyboardType: TextInputType.phone,
                          controller:phoneController,
                          validator: (String ?value){
                            if(value==null || value.isEmpty){
                              return 'please enter your phone';
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
                                'Major',

                              ),
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(
                                  Icons.book
                              )
                          ),
                          keyboardType: TextInputType.text,
                          controller:majorController,
                          validator: (String ?value){
                            if(value==null || value.isEmpty){
                              return 'please enter your major';
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
                                'Cv',

                              ),
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(
                                  Icons.book_rounded
                              )
                          ),
                          keyboardType: TextInputType.text,
                          controller:cvController,
                          validator: (String ?value){
                            if(value==null || value.isEmpty){
                              return 'please enter your cv';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          'Please enter your gender',
                          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                              color: Colors.grey
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          width: double.infinity,
                          child: DropdownButton<String>(
                            value:cubit.roleGender,
                            onChanged: (String? value) {
                              cubit.ChangeGender(value!);
                            },
                            items: <String>['male', 'female'].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        ConditionalBuilder(
                          condition:AddDoctorState is!LoadingRegisterUserState ,
                          builder:(context)=>Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.blue[800],
                                borderRadius: BorderRadiusDirectional.circular(20)
                            ),
                            child: MaterialButton(
                              onPressed: (){
                                if(formKey.currentState!.validate()){
                                  cubit.getUserInfo(
                                      name: userNameController.text,
                                      email: emailAddressController.text,
                                      phone: phoneController.text,
                                      gender: cubit.roleGender,
                                      cv: cvController.text,
                                      major: majorController.text,
                                      password: passswordController.text);


                                }
                                DoctorCubit.get(context).getAllUsers();
                                userNameController.text='';
                                emailAddressController.text='';
                                phoneController.text='';
                                cvController.text='';
                                majorController.text='';
                                passswordController.text='';





                              },
                              child: Text(
                                'Add',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold
                                ),
                              ),

                            ),
                          ) ,
                          fallback:(context)=>Center(child: CircularProgressIndicator()) ,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );

        },
      ),
    );


  }
}