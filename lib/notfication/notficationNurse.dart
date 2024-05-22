import 'package:doctorproject/models/usermodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../7doctor/cubit/cubit.dart';
import '../7doctor/cubit/state.dart';
import '../7doctor/moduels/bookingmodel/entity/userdata.dart';
import '../7doctor/moduels/bookingmodel/firemanger.dart';


class NotificationUserForNurse extends StatefulWidget {
  const NotificationUserForNurse({super.key});

  @override
  State<NotificationUserForNurse> createState() => _NotificationUserState();
}
userModel?usermodel;
class _NotificationUserState extends State<NotificationUserForNurse> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DoctorCubit, DoctorState>(
        listener: (context, DoctorState) {},
        builder: (context, DoctorState) {


          DoctorCubit cubit = DoctorCubit.get(context);
          var modell=DoctorCubit.get(context).model;
          var doctormodell=DoctorCubit.get(context).doctorModel;

          return Scaffold(
            backgroundColor: Colors.grey[200],
            appBar: AppBar(
              centerTitle: false,
              backgroundColor: Colors.blue[800],
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarIconBrightness: Brightness.light,
                statusBarColor: Colors.blue[800]
              ),
              title: Text(
                'Notification',
                style: Theme
                    .of(context)
                    .textTheme
                    .titleLarge,
              ),
            ),
            body: Center(
              child: FutureBuilder<List<NotificationDataFromNurse>>(
                future: Appointment.instance.getTOUserNotificationFromNurse(
                    AppointmentDataNerse(
                        userId: FirebaseAuth.instance.currentUser?.uid,
                      // name: cubit.doctorModel!.uid!, doctoruuid: cubit.doctorModel?.uid!,
                     )),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    List<NotificationDataFromNurse> notificationDataList = snapshot.data!;

                    return ListView.builder(
                      itemCount: notificationDataList.length,
                      itemBuilder: (context, index) {
                        final data = notificationDataList[index];
                        NotificationDataFromNurse notificationData =
                        notificationDataList[index];
                        return Padding(
                          padding: EdgeInsets.all(8.0),
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(width: 2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            leading: const CircleAvatar(
                              backgroundColor: Colors.cyan,
                              child: Icon(Icons.person),
                            ),
                            title: SingleChildScrollView(
                              scrollDirection:Axis.horizontal,
                              child: Row(
                                children: [
                                  Text('status: ${notificationData.status ??
                                      "not given"}'),
                                  const SizedBox(width: 10),
                                  Text(
                                      'longitude: ${notificationData.longitude ?? "not given"}'),
                                  const SizedBox(width: 10),
                                  Text(
                                      'doctor: ${data.doctorName?? "Dana"}'),

                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          );
        });
  }
}
