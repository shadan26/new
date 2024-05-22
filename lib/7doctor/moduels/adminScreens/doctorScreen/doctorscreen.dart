import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubit/cubit.dart';
import '../../../cubit/state.dart';
import '../addDoctorScreen/adddoctorscreen.dart';
import '../userScreen/userscreen.dart';

class DoctorScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DoctorCubit,DoctorState>(
      listener: (context,DoctorState){

      },
      builder: (context,DoctorState){
        var cubit=DoctorCubit.get(context);
        return ConditionalBuilder(
            condition: cubit.doctors.length>0,
            builder:(context)=> ListView.separated(
              physics: BouncingScrollPhysics(),
                itemBuilder: (context,index)=>GetAllUserItem(context,cubit.doctors[index]),
                separatorBuilder: (context,index)=>Container(
                  height: 1,
                  width: double.infinity,
                  padding: EdgeInsetsDirectional.only(
                      start: 10
                  ),
                ),
                itemCount: cubit.doctors.length) ,
            fallback: (context)=>Center(child: CircularProgressIndicator()));
      },
    );
  }

}