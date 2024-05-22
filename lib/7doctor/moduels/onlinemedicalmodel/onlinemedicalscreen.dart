import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:doctorproject/7doctor/cubit/cubit.dart';
import 'package:doctorproject/7doctor/cubit/state.dart';
import 'package:doctorproject/shared/components/shared/shared.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnlineMedical extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DoctorCubit,DoctorState>(
      listener: (context,doctorState){},
      builder: (context,doctorState){
        DoctorCubit cubit=DoctorCubit.get(context);
        return Scaffold(
          appBar: AppBar(

            title: Text(
              'Clincs',
              style:Theme.of(context).textTheme.titleLarge ,
            ),
            actions: [
            ],
          ),
          body:ConditionalBuilder(
            condition:cubit.doctors.length>0 ,
            builder:(context)=>ListView.separated(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context,index)=> buildOnlineClinicItem(cubit.doctors[index], context),
                separatorBuilder: (context,index)=>SizedBox(
                  height: 20,
                ),
                itemCount: cubit.doctors.length) ,
            fallback: (context)=>Center(child: CircularProgressIndicator()),
          )
        );
      },
    );
  }

}