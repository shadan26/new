import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctorproject/7doctor/moduels/adminScreens/addDoctorScreen/state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/usermodel.dart';

class AddDoctorCubit extends Cubit<AddDoctorState>{
  AddDoctorCubit():super(InitialAddDoctorState());
  static AddDoctorCubit get(context)=>BlocProvider.of(context);
  IconData visableIcon=Icons.visibility_off;
  bool isVisable=true;
  void ChangeVisable(){
    isVisable=!isVisable;
    visableIcon=isVisable ? Icons.visibility_off :Icons.visibility;
    emit(ChangeVisablePasswordRegister());

  }



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
    required String gender,
    required String cv,
    required String major
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
          gender: gender,
        cv: cv,
        major: major
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
    required String gender,
    required String major,
    required String cv
  }){
    userModel model=userModel(
        name: name,
        email: email,
        phone: phone,
        uid: uid,
        gender:gender,
        cv: cv,
        major: major,
        image: gender=='male'?'https://cdn-icons-png.flaticon.com/512/4086/4086679.png':'https://cdn.icon-icons.com/icons2/2643/PNG/512/avatar_female_woman_person_people_white_tone_icon_159360.png',
        status: 'doctor'

    );
    FirebaseFirestore
        .instance
        .collection('users')
        .doc(uid)
        .set(model.toMap()).then((value) {
      emit(AddDoctorSuccessState());
    }).
    catchError((error){
      emit(AddDoctorFailedState());

    });


  }

}