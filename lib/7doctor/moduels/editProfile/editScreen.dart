

import 'dart:io';

import 'package:doctorproject/7doctor/cubit/cubit.dart';
import 'package:doctorproject/7doctor/cubit/state.dart';
import 'package:doctorproject/7doctor/moduels/loginmodel/logincubit/cubit.dart';
import 'package:doctorproject/shared/constants/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileScreen extends StatelessWidget{
  var nameController=TextEditingController();
  var phoneController=TextEditingController();
  var emailController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DoctorCubit,DoctorState>(
      listener: (context,DoctorState){

      },
      builder: (context,DoctorState){
        DoctorCubit cubit=DoctorCubit.get(context);
        var profileImage=DoctorCubit.get(context).profileImage;
        var modell=DoctorCubit.get(context).model;
        nameController.text=modell!.name!;
        phoneController.text=modell!.phone!;
        emailController.text=modell!.email!;

        return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blue[800],
              centerTitle: false,
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.blue[800],
                statusBarIconBrightness: Brightness.light
              ),
              title: Text(
                  'Edit Screen',
                  style: Theme.of(context).textTheme.titleLarge
              ),
              actions: [
                TextButton(
                    onPressed: (){
                      cubit.updateUser(context,name: nameController.text
                          , phone: phoneController.text
                          , email: emailController.text);

                    },
                    child: Text(
                      'Update',
                      style: TextStyle(
                        color: Colors.white
                      ),

                    )),
              ],
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsetsDirectional.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          CircleAvatar(
                            radius:75,
                            backgroundImage:(profileImage==null)? NetworkImage(
                                '${modell!.image}'
                            ):FileImage(File(profileImage.path))as ImageProvider,

                          ),
                          CircleAvatar(
                            backgroundColor: Colors.blue[800],
                            child: IconButton(
                                onPressed: (){
                                  DoctorCubit.get(context).getProfileImage();
                                }
                                , icon:Icon(
                                   Icons.edit,
                              color: Colors.white,
                            ) ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          label: Text(
                            'Name'
                          ),
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(
                            Icons.person
                          )
                        ),
                        keyboardType: TextInputType.text,
                        controller: nameController,
                        validator: (String ?value){
                          if(value==null || value.isEmpty){
                            return 'please enter your name';
                          }
                          else
                            return null;
                        },

                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            label: Text(
                                'Phone'
                            ),
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(
                                Icons.phone
                            )
                        ),
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        validator: (String ?value){
                          if(value==null || value.isEmpty){
                            return 'please enter your phone';
                          }
                          else
                            return null;
                        },

                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            label: Text(
                                'Email'
                            ),
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(
                                Icons.email_outlined
                            )
                        ),
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (String ?value){
                          if(value==null || value.isEmpty){
                            return 'please enter your email';
                          }
                          else
                            return null;
                        },

                      ),
                      SizedBox(
                        height: 40,
                      ),
                      if(cubit.profileImage!=null)
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadiusDirectional.circular(20)
                        ),
                        child: MaterialButton(
                          onPressed: (){
                            cubit.uploadProfileImage(context,name: nameController.text, phone: phoneController.text, email: emailController.text);

                          },
                          child: Text(
                            'Update Profile Image ',
                            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                color: Colors.white
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      if(DoctorState is userUpdateLoadingState)
                        LinearProgressIndicator(),





                    ],
                  ),
                ),
              ),
            ),
        );
      },
    );

  }

}