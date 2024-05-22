

import 'package:doctorproject/7doctor/cubit/cubit.dart';
import 'package:doctorproject/7doctor/cubit/state.dart';
import 'package:doctorproject/7doctor/moduels/bookingmodel/bookingscreen.dart';
import 'package:doctorproject/models/usermodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NurseScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DoctorCubit,DoctorState>(
      listener: (context,DoctorState){

      },
      builder: (context,DoctorState){
        var cubit=DoctorCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.grey[200],
            appBar: AppBar(
              backgroundColor: Colors.blue[800],
              centerTitle: false,
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.blue[800],
                statusBarIconBrightness: Brightness.light
              ),
              title: Text(
                  'Clinic',
                style:Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontSize: 30
              ),
              ),
            ),
            body: ListView.separated(
                itemBuilder: (context,index)=>BuildNurseItem(cubit.nurses[index],context),
                separatorBuilder: (context,index)=>SizedBox(
                  height: 10,
                ),
                itemCount: cubit.nurses.length)
        );
      },
    );
  }

}
Widget BuildNurseItem(userModel model,context)=>Padding(
  padding: const EdgeInsets.all(20.0),
  child: Container(
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadiusDirectional.circular(20)
    ),
    clipBehavior: Clip.antiAliasWithSaveLayer,
    child: Row(
      children: [
        Image(
            height: 220,
            width: 170,
            fit: BoxFit.cover,
            image:NetworkImage(
                '${model.image}'
            )),
        SizedBox(
          width: 7,
        ),
        Expanded(
          child: Container(
            height: 200,
            padding: EdgeInsetsDirectional.only(
                bottom: 10,
                start: 10
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  'Name : ${model.name}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Colors.black,
                      fontSize: 17

                  ),
                ),
                Text(
                  'Major : ${model.major}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Colors.black,
                      fontSize: 17

                  ),
                ),
                Text(
                    'Experience : 8 Years',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Colors.black,
                      fontSize: 17

                  ),
                ),
                Text(
                    'Patients : 2800',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Colors.black,
                      fontSize: 17

                  ),
                ),
                Spacer(),
                Container(
                  height: 35,
                  width: 170,

                  decoration: BoxDecoration(
                      color: Colors.blue[800],
                      borderRadius: BorderRadiusDirectional.circular(20)
                  ),
                  child: MaterialButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>BookScreen(
                        name: model.name,
                        major: model.major,
                        email: model.email,
                        phone: model.phone,
                        dateOfBirth: model.date,
                        description: model.cv,
                        image: model.image,
                        usermodel: model,
                        uid: model.uid, id: model.id, token: model.token, statuss: model.status,)));

                  },
                    child: const Text(
                      'Book',
                      style: TextStyle(
                          color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                      ),
                    ),),
                )
              ],
            ),
          ),
        )
      ],
    ),
  ),
);