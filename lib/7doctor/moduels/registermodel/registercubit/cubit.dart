

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctorproject/7doctor/cubit/cubit.dart';
import 'package:doctorproject/7doctor/moduels/registermodel/registercubit/state.dart';
import 'package:doctorproject/models/doctormodel.dart';
import 'package:doctorproject/models/usermodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterCubit extends Cubit<RegisterState>{
  RegisterCubit():super(InitailRegisterState());
  static RegisterCubit get(context)=>BlocProvider.of(context);
  String roleGender='male';
  void ChangeGender(var value){
    roleGender=value;
    emit(ChangeGenderSuccess());

  }

  void getUserInfo({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String gender
  }){
    emit(LoadingRegisterUserState());

    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password).then((value) {
      print(value.user!.email);
      print(value.user!.uid);
      UserCreate(
          name: name
          , email: email
          , phone: phone
          , uid: value.user!.uid,
          gender: gender
      );

    }).catchError((error){
      print(error.toString());
      emit(RegisterUserError(error.toString()));


    });

  }

  void UserCreate({  // the data here stored in fire store
    required String name,
    required String email,
    required String phone,
    required String uid,
    required String gender
  }){
    userModel model=userModel(
        name: name,
        email: email,
        phone: phone,
        uid: uid,
        gender:gender,
        image: gender=='male'?'https://cdn-icons-png.flaticon.com/512/4086/4086679.png':'https://cdn.icon-icons.com/icons2/2643/PNG/512/avatar_female_woman_person_people_white_tone_icon_159360.png',
        status: 'user'

    );
    FirebaseMessaging.instance.subscribeToTopic(model!.status!);
    FirebaseFirestore
        .instance
        .collection('users')
        .doc(uid)
        .set(model.toMap()).then((value) {
      emit(CreateUserSuccessState());
    }).
    catchError((error){
      emit(CreaterUserErrorState(error.toString()));

    });


  }



  IconData visableIcon=Icons.visibility_off;
  bool isVisable=true;




  void ChangeVisable(){
    isVisable=!isVisable;
    visableIcon=isVisable ? Icons.visibility_off :Icons.visibility;
    emit(ChangeVisablePasswordRegister());

  }








}
