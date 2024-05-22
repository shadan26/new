import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctorproject/7doctor/moduels/bookingmodel/bookingscreen.dart';
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


class NotificationUser extends StatefulWidget {
  NotificationUser({super.key});
  List<QueryDocumentSnapshot<Object?>>? docs;

  @override
  State<NotificationUser> createState() => _NotificationUserState();
}
userModel?usermodel;
class _NotificationUserState extends State<NotificationUser> {

  @override
  void initState() {
    Appointment.instance.viewNotifications().then((value) => {
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DoctorCubit, DoctorState>(
        listener: (context, DoctorState) {},
        builder: (context, DoctorState) {

BookScreen bookScreen=BookScreen();
          DoctorCubit cubit = DoctorCubit.get(context);

          var modell=DoctorCubit.get(context).model;
          var doctormodell=DoctorCubit.get(context).doctorModel;

          return Scaffold(
            backgroundColor: Colors.grey[200],
            appBar: AppBar(
              backgroundColor: Colors.blue[800],
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.blue[800],
                statusBarIconBrightness: Brightness.light
              ),
              centerTitle: false,
              title: Text(
                'Notification',
                style: Theme
                    .of(context)
                    .textTheme
                    .titleLarge,
              ),
            ),
            body: Center(
              child: FutureBuilder<List<NotificationData>>(
                future: Appointment.instance.getTOUserNotification(
                    AppointmentData(
                      appointmentId: bookScreen.appointmentId,
                        doctorname: bookScreen.usermodel ,
                    doctoruuid: usermodel?.uid,
                        time: usermodel?.date,
                        userId: FirebaseAuth.instance.currentUser?.uid)),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    List<NotificationData> notificationDataList = snapshot
                        .data! ;

                    return ListView.builder(
                        itemCount: notificationDataList.length ,
                        itemBuilder: (context, index) {
                          final data = notificationDataList[index] ;
                         // final d = notificationDataList?[index].data() as Map<String, dynamic>;
                          NotificationData notificationData =
                          notificationDataList[index] ;
                          var userId = FirebaseAuth.instance.currentUser?.uid;
                          return InkWell(
                            onTap: () {
                              Appointment.instance.readNotification(
                                  notificationData.appointmentId!)
                                  .then((value) =>
                              {
                                setState(() {
                                  notificationData.isOpened= true;
                                })
                              });
                            },
                              child:
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: ListTile(
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(width: 2),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  leading: CircleAvatar(
                                    backgroundColor: Colors.cyan,
                                    backgroundImage: NetworkImage(notificationData.doctorImage!),
                                    radius: 30,

                                  ),

                                  title: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Card(
                                      color:notificationData.isOpened != null ?Colors.white : Colors.grey,
                                      child: Row(
                                        children: [
                                          Text('status: ${notificationData
                                              .status ??
                                              "not given"}'),
                                          const SizedBox(width: 10),
                                          Text(
                                              'Time: ${notificationData.date ??
                                                  "not given"}'),
                                          const SizedBox(width: 10),
                                          Text(
                                              'doctor: ${notificationData.doctorName ??
                                                  "not given"}'),

                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                          );
                        }
                    );
                  };}),
            ),
          );
        });
  }
}
