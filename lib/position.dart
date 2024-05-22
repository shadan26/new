import 'package:doctorproject/7doctor/homescreen/homescreentwo.dart';
import 'package:doctorproject/7doctor/moduels/bookingmodel/entity/userdata.dart';
import 'package:doctorproject/7doctor/moduels/bookingmodel/firemanger.dart';
import 'package:doctorproject/models/usermodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class FillPositionPage extends StatefulWidget {
  final LatLng initialPosition;

  const FillPositionPage({super.key, required this.initialPosition});

  @override
  _FillPositionPageState createState() => _FillPositionPageState();
}

class _FillPositionPageState extends State<FillPositionPage> {
  TextEditingController gender = TextEditingController();
  TextEditingController name = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.blue[800],
        centerTitle: false,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.light,
            statusBarColor: Colors.blue[800]
          ),
          title: const Text('Fill Position'),

      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image(
                    image: AssetImage(
                      'assets/images/map.png'
                    )),
                SizedBox(height: 40),
                TextFormField(
                  controller: name,
                  decoration: InputDecoration(
                      labelText: 'name',
                    prefixIcon: Icon(
                      Icons.drive_file_rename_outline
                    ),
                    border: OutlineInputBorder()
                  ),
                  keyboardType: TextInputType.text,
                ),
                SizedBox(
                  height: 20,
                ),

                TextFormField(

                  controller: gender,
                  decoration: InputDecoration(
                      labelText: 'gender',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(
                      Icons.person
                    )

                  ),
                  keyboardType: TextInputType.text,
                ),
                // TextFormField(
                //     controller: latitudeController,
                //     decoration: InputDecoration(labelText: 'Latitude'),
                //     keyboardType: TextInputType.number),
                // SizedBox(height: 10),
                // TextFormField(
                //   controller: longitudeController,
                //   decoration: InputDecoration(labelText: 'Longitude'),
                //   keyboardType: TextInputType.number,
                // ),
                SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.blue[800],
                    borderRadius: BorderRadiusDirectional.circular(20)
                  ),
                  child: MaterialButton(
                      onPressed: (){
                        var data = AppointmentDataNerse(
                                   userId: FirebaseAuth.instance.currentUser?.uid,
                                     status: "initial",
                                     name: name.text,
                                     gender: gender.text,
                                     latitude: widget.initialPosition.latitude,
                                     longitude: widget.initialPosition.longitude,
                                     doctoruuid: "ygsiBi8mpQdQGLWtXu6Joa2w2mw1",
                                   );
                                   //Appointment.instance.sendPushNotificationTopic(usermodel!.token!);
                                   Appointment.instance.bookAppointmentnurse(data).then((value) {
                                     Fluttertoast.showToast(
                                         msg: "Successfully",
                                         toastLength: Toast.LENGTH_LONG,
                                         gravity: ToastGravity.BOTTOM,
                                         timeInSecForIosWeb: 1,
                                         backgroundColor: Colors.blue,
                                         textColor: Colors.white,
                                         fontSize: 16.0
                                     );
                                     Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomeScreenTwo()), (route) => false);
                                   }).catchError((error){
                                     Fluttertoast.showToast(
                                         msg: "Failled",
                                         toastLength: Toast.LENGTH_LONG,
                                         gravity: ToastGravity.BOTTOM,
                                         timeInSecForIosWeb: 1,
                                         backgroundColor: Colors.blue,
                                         textColor: Colors.white,
                                         fontSize: 16.0
                                     );
                                   });
                        
                      },
                    child: Text(
                      'Appointment',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20
                      ),
                    ),
                      ),
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}
