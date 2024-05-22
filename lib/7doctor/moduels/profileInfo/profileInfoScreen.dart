import 'dart:io';

import 'package:doctorproject/7doctor/cubit/cubit.dart';
import 'package:doctorproject/7doctor/cubit/state.dart';
import 'package:doctorproject/7doctor/moduels/loginmodel/logincubit/cubit.dart';
import 'package:doctorproject/shared/constants/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileInfo extends StatelessWidget{
  var nameController=TextEditingController();
  var phoneController=TextEditingController();
  var emailController=TextEditingController();
  var uidController=TextEditingController();
  var majorController=TextEditingController();
  var cvController=TextEditingController();
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
        uidController.text=modell!.uid!;
          if(modell?.status=='doctor')
         //   print('qusaiii');
          majorController.text=modell!.major!;
         // print(majorController.text);
          if(modell?.status=='doctor')
          cvController.text=modell!.cv!;
        print(modell.cv);
        print(modell.major);

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blue[800],
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarIconBrightness: Brightness.light,
              statusBarColor: Colors.blue[800]
            ),
            centerTitle: false,
            title: Text(
                'Profile Info',
                style: Theme.of(context).textTheme.titleLarge
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              padding: EdgeInsetsDirectional.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: [
                      CircleAvatar(
                        radius:50,
                        backgroundImage: NetworkImage(
                          '${modell!.image}'
                        ),

                      ),
                    ],
                  ),
                  Text(
                    '${modell!.name}',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Colors.black
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        label: Text(
                            'Name'
                        ),
                      enabled: false
                    ),
                    keyboardType: TextInputType.text,
                    controller: nameController,

                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        label: Text(
                            'Phone'
                        ),


                    ),
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    enabled: false,

                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        label: Text(
                            'Email'
                        ),


                    ),
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    enabled: false,

                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      label: Text(
                          'uid'
                      ),


                    ),
                    controller: uidController,
                    keyboardType: TextInputType.emailAddress,
                    enabled: false,

                  ),
                  SizedBox(
                    height: 40,
                  ),
                  if(modell?.status=='doctor')
                    TextFormField(
                      decoration: InputDecoration(
                        label: Text(
                            'Major'
                        ),


                      ),
                      controller: majorController,
                      keyboardType: TextInputType.phone,
                      enabled: false,

                    ),
                  SizedBox(
                    height: 40,
                  ),
                  if(modell?.status=='doctor')
                    TextFormField(
                      decoration: InputDecoration(
                        label: Text(
                            'Cv'
                        ),


                      ),
                      controller: cvController,
                      keyboardType: TextInputType.phone,
                      enabled: false,

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
        );
      },
    );

  }

}