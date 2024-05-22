import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctorproject/7doctor/cubit/cubit.dart';
import 'package:doctorproject/7doctor/cubit/state.dart';
import 'package:doctorproject/7doctor/homescreen/homescreen.dart';
import 'package:doctorproject/7doctor/moduels/messagemodel/messagemodelscreen.dart';
import 'package:doctorproject/7doctor/moduels/settingmodel/settingScreen.dart';
import 'package:doctorproject/models/usermodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import '../../homescreen/homescreentwo.dart';
import '../bookingmodel/entity/userdata.dart';
import '../bookingmodel/firemanger.dart';
import '../messagemodel/messagedoctor.dart';
import '../settingmodel/settingdoctor.dart';


class TimeScreen extends StatefulWidget {
  List<QueryDocumentSnapshot<Object?>>? docs;

  @override
  State<TimeScreen> createState() => _TimeScreenState(this.docs);
}

class _TimeScreenState extends State<TimeScreen> {
  _TimeScreenState(List<QueryDocumentSnapshot<Object?>>? docs);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DoctorCubit, DoctorState>(
      listener: (context, DoctorState) {},
      builder: (context, DoctorState) {
        DoctorCubit cubit = DoctorCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.grey[200],

            appBar: AppBar(
              leading: IconButton(
                onPressed:(){
                  Navigator.pop(context);
                } ,
                icon: Icon(
                  Icons.chevron_left
                ),
              ),
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarIconBrightness: Brightness.light,
                statusBarColor: Colors.blue[800]
              ),
              backgroundColor: Colors.blue[800],
              centerTitle: false
              ,
              title: Text(
                'Time Screen',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            body: Center(
              child: FutureBuilder<List<AppointmentData>>(
                future: Appointment.instance.getBookAppointmentData(
                    AppointmentData(
                        time: cubit.doctorModel?.date,
                        date: cubit.doctorModel?.date,
                        patientname: cubit.model?.name,
                        userId: FirebaseAuth.instance.currentUser?.uid)),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    List<AppointmentData> appointmentDataList = snapshot.data!;

                    return ListView.builder(
                      itemCount: appointmentDataList.length,
                      itemBuilder: (context, index) {
                        final data = appointmentDataList[index];
                        var userId = FirebaseAuth.instance.currentUser?.uid;
                        var dat = AppointmentData(
                            userId: userId,
                            date: data.date,
                            time: data.time);
                        AppointmentData appointmentData =
                        appointmentDataList[index];
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
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  Text('Date: ${appointmentData.date ?? "not given"}'),
                                  const SizedBox(width: 10),
                                  Text('Time: ${appointmentData.time ?? "not given"}'),
                                  const SizedBox(width: 10),
                                  Text('Patient : ${appointmentData.patientname ?? "not given"}'),
                                ],
                              ),
                            ),
                            subtitle: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child:
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    if(appointmentData.status == "initial")
                                      Row(
                                          children: [
                                            ElevatedButton(
                                              onPressed: () async {
                                                var tokenSnapshot = await FirebaseFirestore.instance
                                                    .collection('users')
                                                    .doc(appointmentData.userId)
                                                    .get();
                                                if (tokenSnapshot.exists) {
                                                  var userData = tokenSnapshot.data();
                                                  var token = userData?['token'];
                                                 Appointment.instance.sendNotification(token);
                                                  setState(() {
                                                    Appointment.instance.updateAppointmentStatus(appointmentData.appointmentId!, "accepted");
                                                    Appointment.instance.saveToUserNotifications(appointmentData, "accepted");
                                                  });
                                                } else {
                                                  const Text("error Found");
                                                }
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.green,
                                              ),
                                              child: Text(
                                                appointmentData.status == 'initial' ? 'Accept' : 'Decline',
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            ElevatedButton(
                                              onPressed: () async {
                                                var tokenSnapshot = await FirebaseFirestore.instance
                                                    .collection('users')
                                                    .doc(appointmentData.userId)
                                                    .get();
                                                if (tokenSnapshot.exists) {
                                                  var userData = tokenSnapshot.data();
                                                  var token = userData?['token'];
                                                  Appointment.instance.sendNotification(token);
                                                  setState(() {
                                                    Appointment.instance.updateAppointmentStatus(appointmentData.appointmentId!, "rejected");
                                                    Appointment.instance.saveToUserNotifications(appointmentData, "rejected");
                                                  });
                                                } else {
                                                  const Text("error Found");
                                                }
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.red,
                                              ),
                                              child: const Text("Decline"),
                                            ),
                                          ]
                                      ),
                                    if(appointmentData.status == "accepted")

                                      const Text("Accepted"),

                                    if(appointmentData.status == "rejected")
                                      const Text("Rejected"),
                                  ],
                                ),
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
      },
    );
  }
}
