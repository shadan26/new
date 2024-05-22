
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctorproject/7doctor/cubit/state.dart';
import 'package:doctorproject/7doctor/moduels/loginmodel/logincubit/cubit.dart';
import 'package:doctorproject/models/doctormodel.dart';
import 'package:doctorproject/models/messageModel.dart';
import 'package:doctorproject/models/usermodel.dart';
import 'package:doctorproject/shared/constants/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storge;

import '../moduels/adminScreens/addDoctorScreen/adddoctorscreen.dart';
import '../moduels/adminScreens/doctorScreen/doctorscreen.dart';
import '../moduels/adminScreens/userScreen/userscreen.dart';
import '../moduels/bookingmodel/firemanger.dart';

class DoctorCubit extends Cubit<DoctorState> {
  DoctorCubit() :super(InitialDoctorState());
  static DoctorCubit get(context) => BlocProvider.of(context);
  List<userModel> doctors = [];
  List<userModel> users = [];
  List<userModel> nurses= [];
  List<userModel> doctorHomeScreentwo=[];
  userModel ?model;
  DoctorModel ?doctorModel;
  int currentIndex = 0;
  File ?profileImage;
  var picker = ImagePicker();
  File ?image;

  Future getProfileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(ProfileImagePickerSucsess());
    } else {
      emit(ProfileImagePickerError());
      print('No Image selected');
    }
  }
  Future openGalaryToSendImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image = File(pickedFile.path);
      emit(ProfileImagePickerSucsess());
    } else {
      emit(ProfileImagePickerError());
      print('No Image selected');
    }
  }

  void changeCureentIndex(index) {
    currentIndex = index;
    emit(ChangeCurrentIndexState());

  }
  void uploadProfileImage(context,{
    required String name,
    required String phone,
    required String email
  }) {
    emit(userUpdateLoadingState());
    firebase_storge
        .FirebaseStorage
        .instance
        .ref()
        .child('users/${Uri
        .file(profileImage!.path)
        .pathSegments
        .last}')
        .putFile(profileImage!).then((p0) {
      p0.ref.getDownloadURL().then((value) {
        updateUser(context,
            name: name,
            phone: phone,
            email: email,
            profileImage: value
        );
      }).catchError((error) {
        emit(ProfileImageUploadrror());
      });
    }).catchError((error) {
      print(error.toString());
      emit(ProfileImageUploadrror());
    });
  }

  Future<void> updateUser(context,{
    required String name,
    required String phone,
    required String email,
    var profileImage
  }) async {
    emit(userUpdateLoadingState());

    userModel modell = userModel(
        token:  await Appointment.instance.getToken(),
        name: name,
        email: email,
        phone: phone,
        uid: model?.uid,
        status: model?.status,
        image: profileImage ?? model?.image


    );
    if (model != null && model!.status != null) {
      FirebaseMessaging.instance.subscribeToTopic(model!.status!);
    }

    FirebaseFirestore
        .instance
        .collection('users')
        .doc(model!.uid)
        .update(modell.toMap()).then((value) {
      getUserData();
      emit(updateUserSuccsesState());
    }).catchError((error) {
      emit(updateUserErrorState());
    });
  }


  void GetAllNurses(){
    nurses=[];
    emit(LoadingGetAllNurses());
    FirebaseFirestore.instance.collection('users').get().then((value) {
      value.docs.forEach((element) {
        if(element.data()['status']=='nurse')
          nurses.add(userModel.fromJson(element.data()));

      });
      emit(GetAllNursesSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetAllNursesFailedState());
    });

  }

  List<Widget> ChangeScreen=[
    AddDoctorScreen(),
    UserScreen(),
    DoctorScreen()
  ];
  List<String> ChangeTitle=[
    'Add Screen',
    'User Screen',
    'Doctor Screen'
  ];

  Future getUserData() async {
    await FirebaseFirestore.instance.collection('users').doc(uid).get().then((
        value) {
      model = userModel.fromJson(value.data()!);
      print(model!.cv);
      GetAllDoctoreHomeScreenTwo();

    }).catchError((error) {
      print(error.toString());
      emit(GetUserDataError(error.toString()));
    });
  }
  void getAllUsers(){
    users=[];
    doctors=[];
    nurses=[];
    emit(LoadingGetAllUsers());
    if(model!.status=='doctor'||model!.status=='nurse') {
      FirebaseFirestore.instance.collection('users').get().then((value) {
        value.docs.forEach((element) {
          print(element.data());
          if(element.data()['status']=='user')
            users.add(userModel.fromJson(element.data()));
        });
        emit(GetAllUsersSuccess());
      }).catchError((error) {
        print(error.toString());
        emit(GetAllUsersError(error.toString()));
      });
    }
    else if(model!.status=='user'){
      emit(LoadingGetAllDoctors());
      FirebaseFirestore.instance.collection('users').get().then((value) {
        value.docs.forEach((element) {
          if(element.data()['status']=='doctor')
            doctors.add(userModel.fromJson(element.data()));
        });
        emit(GetAllDoctorsSuccess());
      }).catchError((error) {
        print(error.toString());
        emit(GetAllDoctorsError(error.toString()));
      });


    }
    else
      if(model!.status=='admin'){
        FirebaseFirestore.instance.collection('users').get().then((value) {
          value.docs.forEach((element) {
            print(element.data());
            if(element.data()['status']=='user')
              users.add(userModel.fromJson(element.data()));
            else if(element.data()['status']=='doctor')
              doctors.add(userModel.fromJson(element.data()));
          });
          emit(GetAllUsersSuccess());
        }).catchError((error) {
          print(error.toString());
          emit(GetAllUsersError(error.toString()));
        });

      }
  }
  void GetAllDoctoreHomeScreenTwo(){
    doctorHomeScreentwo=[];

    FirebaseFirestore.instance.collection('users').get().then((value) {
      value.docs.forEach((element) {
        if(element.data()['status']=='doctor')
          doctorHomeScreentwo.add(userModel.fromJson(element.data()));

      });
      emit(GetAllDoctorHomeScreenTwoSuccess());
      emit(GetUserDataSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(GetAllDoctorHomeScreenTwoFailed());
    });

  }

  void sendMessage({
    required String receiverId,
    required String dateTime,
    required String text,
    String ?image


  }){
    MessageModel messageModel = MessageModel(
      text: text,
      dateTime: dateTime,
      senderId: model?.uid,
      reciverId: receiverId,

    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(model?.uid)
        .collection('chats')
        .doc(receiverId)
        .collection('message')
        .add(messageModel.toMap()).then((value) {
      emit(SendMessageSuccessState());

    }).catchError((error){
      emit(SendMessageErrorState(error));

    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(model?.uid)
        .collection('message')
        .add(messageModel.toMap()).then((value) {
      emit(SendMessageSuccessState());

    }).catchError((error){
      emit(SendMessageErrorState(error));

    });


  }

  List<MessageModel> messages=[];
  void getMessages({
    required String receiverId
  }){
    FirebaseFirestore.instance.
    collection('users').
    doc(model!.uid).
    collection('chats').
    doc(receiverId).
    collection('message').orderBy('dateTime').
    snapshots()
        .listen((event) {
      messages=[];
      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));


      });
      emit(GetMessageSuccessState());

    });
  }









}




