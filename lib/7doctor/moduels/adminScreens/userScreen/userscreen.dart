import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:doctorproject/7doctor/cubit/cubit.dart';
import 'package:doctorproject/7doctor/cubit/state.dart';
import 'package:doctorproject/7doctor/moduels/adminScreens/doctorScreen/doctorscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../models/usermodel.dart';
import '../addDoctorScreen/adddoctorscreen.dart';

class UserScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   return BlocConsumer<DoctorCubit,DoctorState>(
     listener: (context,DoctorState){

     },
     builder: (context,DoctorState){
       var cubit=DoctorCubit.get(context);
       return ConditionalBuilder(
           condition: cubit.users.length>0,
           builder:(context)=> ListView.separated(
             physics: BouncingScrollPhysics(),
               itemBuilder: (context,index)=>GetAllUserItem(context,cubit.users[index]),
               separatorBuilder: (context,index)=>Container(
                 height: 1,
                 width: double.infinity,
                 padding: EdgeInsetsDirectional.only(
                   start: 10
                 ),
               ),
               itemCount: cubit.users.length) ,
           fallback: (context)=>Center(child: CircularProgressIndicator()));




     },
   );
  }

}
Widget GetAllUserItem(context,userModel model)=>Dismissible(
  key: Key('qusai'),
  onDismissed: (direction){
    FirebaseFirestore.instance.collection('users').doc(model.uid).delete().then((value) {
      Fluttertoast.showToast(
          msg: "Delete Success",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }).catchError((error){

      Fluttertoast.showToast(
          msg: "Delete Failed",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0
      );

    });

  },
  child:   Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        CircleAvatar(
          backgroundImage:NetworkImage(
              '${model.image}'
          ),
          radius: 50,
        ),
        SizedBox(
          width:10 ,
        ),
        Text(
            '${model.name}',
          style: TextStyle(
            fontSize: 20
          ),
        ),
        Spacer(),
        CircleAvatar(
          backgroundColor: Colors.blue,
          radius: 7,
        )
      ],
    ),
  ),
);