import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctorproject/7doctor/cubit/cubit.dart';
import 'package:doctorproject/7doctor/cubit/state.dart';
import 'package:doctorproject/7doctor/homescreen/homescreen.dart';
import 'package:doctorproject/7doctor/moduels/messagemodel/messagemodelscreen.dart';
import 'package:doctorproject/7doctor/moduels/settingmodel/settingScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../bookingmodel/entity/userdata.dart';
import '../../bookingmodel/firemanger.dart';
import '../../timemodel/timescreen.dart';

class TimeScreenNurse extends StatefulWidget {
  List<QueryDocumentSnapshot<Object?>>? docs;

  @override
  State<TimeScreenNurse> createState() => _TimeScreenState(this.docs);
}

class _TimeScreenState extends State<TimeScreenNurse> {
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
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarIconBrightness: Brightness.light,
                statusBarColor: Colors.blue[800]
              ),
              backgroundColor: Colors.blue[800],
              centerTitle: false,
              title: Text(
                'Time Screen',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            body: Center(
              child: FutureBuilder<List<AppointmentDataNerse>>(
                future: Appointment.instance
                    .getBookAppointmentDataForNurse(AppointmentDataNerse(
                  userId: FirebaseAuth.instance.currentUser?.uid,
                  doctoruuid: cubit.model!.uid!,
                  name: cubit.model!.name!,
                )),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    List<AppointmentDataNerse> appointmentDataList =
                        snapshot.data!;

                    return ListView.builder(
                      itemCount: appointmentDataList.length,
                      itemBuilder: (context, index) {
                        final data = appointmentDataList[index];
                        var userId = FirebaseAuth.instance.currentUser?.uid;
                        var dat = AppointmentDataNerse(
                            userId: userId,
                            doctoruuid: data.doctoruuid,
                            name: data.name,
                            gender: data.gender,
                            latitude: data.latitude,
                            longitude: data.longitude);
                        AppointmentDataNerse appointmentDataNerse =
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
                                  Text(
                                      'name: ${appointmentDataNerse.name ?? "not given"}'),
                                  const SizedBox(width: 10),
                                  Text(
                                      'latitude: ${appointmentDataNerse.latitude ?? "not given"}'),
                                  const SizedBox(width: 10),
                                  Text(
                                      'longitude: ${appointmentDataNerse.longitude ?? "not given"}'),
                                ],
                              ),
                            ),
                            subtitle: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    if (appointmentDataNerse.status ==
                                        "initial")
                                      Row(children: [
                                        ElevatedButton(
                                          onPressed: () async {
                                            var tokenSnapshot =
                                                await FirebaseFirestore.instance
                                                    .collection('users')
                                                    .doc(appointmentDataNerse
                                                        .userId)
                                                    .get();
                                            if (tokenSnapshot.exists) {
                                              var userData =
                                                  tokenSnapshot.data();
                                              var token = userData?['token'];
                                              Appointment.instance
                                                  .sendNotification(token);
                                              setState(() {
                                                Appointment.instance
                                                    .updateAppointmentStatusForNurse(
                                                        appointmentDataNerse
                                                            .appointmentId!,
                                                        "accepted");
                                                Appointment.instance
                                                    .saveToUserNotificationsFromNurse(
                                                        appointmentDataNerse,
                                                        "accepted");
                                              });
                                            } else {
                                              const Text("error Found");
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.green,
                                          ),
                                          child: Text(
                                            appointmentDataNerse.status ==
                                                    'initial'
                                                ? 'Accept'
                                                : 'Decline',
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        ElevatedButton(
                                          onPressed: () async {
                                            var tokenSnapshot =
                                                await FirebaseFirestore.instance
                                                    .collection('users')
                                                    .doc(appointmentDataNerse
                                                        .userId)
                                                    .get();
                                            if (tokenSnapshot.exists) {
                                              var userData =
                                                  tokenSnapshot.data();
                                              var token = userData?['token'];
                                              Appointment.instance
                                                  .sendNotification(token);
                                              setState(() {
                                                Appointment.instance
                                                    .updateAppointmentStatusForNurse(
                                                        appointmentDataNerse
                                                            .appointmentId!,
                                                        "rejected");
                                                Appointment.instance
                                                    .saveToUserNotificationsFromNurse(
                                                        appointmentDataNerse,
                                                        "rejected");
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

                                      ]),
                                    if (appointmentDataNerse.status ==
                                        "accepted")
                                      const Text("Accepted"),
                                    if (appointmentDataNerse.status ==
                                        "rejected")
                                      const Text("Rejected"),
                                    const SizedBox(width: 8),
                                    IconButton(
                                        onPressed: () {
                                          driveToLocation(latitude: appointmentDataNerse.latitude!, longitude: appointmentDataNerse.longitude!);
                                        },
                                        icon: Icon(Icons.location_on))
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
            ));
      },
    );
  }
  static driveToLocation({
    required double latitude,
    required double longitude,
  }) async {
    final url =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    await launchUrl(Uri.parse(url));
  }
}
