import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctorproject/7doctor/moduels/bookingmodel/entity/userdata.dart';
import 'package:doctorproject/7doctor/moduels/chatModel/chatScreen.dart';
import 'package:doctorproject/7doctor/moduels/paymentmodel/paymentscreen.dart';
import 'package:doctorproject/models/usermodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import'package:flutter/material.dart';

import '../../../map_screen.dart';
import '../../cubit/cubit.dart';
import 'firemanger.dart';
class BookScreen extends StatefulWidget{
  var id;
  var name;
  var usermodel;
  var major;
  var email;
  var phone;
  var dateOfBirt;
  var description;
  var image;
  var statuss;
  var uid;
  var token;
  var appointmentId;

  BookScreen({
    var appointmentId,
    var statuss,
    var id,
   var name,
  var major,
    var email,
    var phone,
     var dateOfBirth,
     var description,
    var image,
   var uid,
  var token,
    var usermodel
  }){
    this.appointmentId=appointmentId;
    this.id=id;
    this.statuss=statuss;
    this.name=name;
    this.major=major;
    this.email=email;
    this.token=token;
    this.phone=phone;
    this.dateOfBirt=dateOfBirth;
    this.description=description;
    this.image=image;
    this.uid=uid;
    this.usermodel=usermodel;
  }


  @override
  State<BookScreen> createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {


  Color wcolor= Colors.white;

  Color bcolor =Colors.black;

  Color pcolor=Color(0xFF0C84FF);

  DateTime datetime=DateTime.now();

  TimeOfDay timeOfDay=TimeOfDay.now();

  var CalenderController=TextEditingController();

  var TimeController=TextEditingController();

  var FormKey=GlobalKey<FormState>();

  var bookTimeArray = ["9:00 AM", "10:00 AM", "11:00 AM", "12:00 PM", "1:00 PM"];
  var bookDateArray=["8 DEC","9 DEC", "10 DEC","11 DEC"];

  var selectedTimeIndex = 0;
  var selectedDateIndex = 0;

  @override
  Widget build(BuildContext context) {

    Color pColor = Colors.blue.shade800;
    var modell=DoctorCubit.get(context).model;
    return Scaffold(
      //color: const Color(0xFFD9E4EE),
      appBar: AppBar(
        backgroundColor: Colors.blue[800],
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light,
          statusBarColor: Colors.blue[800]
        ),
        title: Text(
          '${widget.name}',
          style: TextStyle(
            fontSize: 30
          ),
        ),

      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2.1,
              decoration:  BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage("${widget.image}"),
                    fit: BoxFit.cover
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  gradient: LinearGradient(
                    colors: [
                      pColor.withOpacity(0.9),
                      pColor.withOpacity(0),
                      pColor.withOpacity(0),
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 30, left: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [



                          // Add other widgets here if needed
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Patient",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                //height: 8,
                                child: Text(
                                  "2800 k",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                              )

                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Experience",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                //height: 8,
                                child: Text(
                                  "8 y",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                              )

                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Rating",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                //height: 8,
                                child: Text(
                                  "4.9",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                              )

                            ],
                          ),
                        ],
                      ),
                    )

                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${widget.name}",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w500,
                      color: pColor,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(
                        Icons.add,
                        color: Colors.red,
                        size: 28,// Set the color of the icon to red
                      ),
                      const SizedBox(width: 5,),
                      Text("${widget.major}",style: TextStyle(
                        fontSize: 17,
                        color: bcolor.withOpacity(0.6),
                      ),)
                    ],
                  ),
                  const SizedBox(height: 15),
                  Text(
                    "${widget.description}",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.black.withOpacity(0.6), // Set the text color to black with 60% opacity
                    ),
                    textAlign: TextAlign.justify, // Align text to justify
                  ),
                  SizedBox(height: 15),

                  Center(
                    child: Text(
                      "Book Date",
                      style: TextStyle(
                          fontSize: 18,
                          color:Colors.blue[800],
                          fontWeight: FontWeight.w600// Assuming bColor is defined elsewhere
                      ),
                    ),
                  ),
                  const SizedBox(height: 8,),
                  Container(
                    height: 70,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: bookDateArray.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              selectedDateIndex = index;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                            padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 20),
                            decoration: BoxDecoration(
                              color: selectedDateIndex == index ? pColor : const Color(0xFFF2F8FF), // Check if this button is tapped
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 4,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  bookDateArray[index],
                                  style: TextStyle(
                                    color: selectedDateIndex == index ? Colors.white : bcolor.withOpacity(0.6),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );


                      },
                    ),
                  ),
                  Column(
                    children: [
                      const SizedBox(height: 5),
                      Center(
                        child: Text(
                          "Book Time",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.blue[800],
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        height: 60,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: bookTimeArray.length,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: (){
                                setState(() {
                                  selectedTimeIndex=index;
                                });
                              },
                              child: Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                                  decoration: BoxDecoration(
                                    color: selectedTimeIndex==index ? pColor : Color(0xFFF2F8FF),
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 4,
                                        spreadRadius: 2,
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Text(
                                      bookTimeArray[index],
                                      style: TextStyle(
                                        fontSize: 17,
                                        color: selectedTimeIndex==index ? Colors.white : bcolor.withOpacity(0.6),
                                      ),
                                    ),
                                  )

                              ),
                            );

                          },
                        ),
                      ),
                      const SizedBox(height: 20,),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsetsDirectional.only(
                                  bottom: 20
                              ),
                              child: Material(
                                color: Colors.blue[800],
                                borderRadius: BorderRadius.circular(10),
                                child: InkWell(
                                  onTap: (){
                                    var date = bookDateArray[selectedDateIndex];
                                    var time = bookTimeArray[selectedTimeIndex];
                                    var doctorId =widget.uid;
                                    var userId = FirebaseAuth.instance.currentUser?.uid;
                                    var doctorname=widget.name;
                                    var patientname =modell?.name ;
                                    var appointmentId = widget.appointmentId;


                                    var data = AppointmentData(status: "initial",time: time, date: date, doctoruuid: doctorId, userId: userId,doctorname: doctorname ,patientname: patientname,appointmentId: appointmentId);
                                    Appointment.instance.sendPushNotificationTopic(widget.token);
                                    Appointment.instance.bookAppointment(data).then((value) {
                                      if(widget.statuss=='doctor')
                                      Fluttertoast.showToast(
                                          msg: "Successfully",
                                          toastLength: Toast.LENGTH_LONG,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.blue,
                                          textColor: Colors.white,
                                          fontSize: 16.0
                                      );
                                    }).catchError((error){
                                      if(widget.statuss=='doctor')
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
                                    if(widget.statuss=="nurse")
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => MapScreen()),
                                    );

                                  } ,
                                  child: Container(
                                      height: 40,
                                      width:  MediaQuery.of(context).size.width,
                                      child: Center(
                                          child:Text("Book",
                                              style: Theme.of(context).textTheme.titleLarge
                                          )
                                      )),


                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsetsDirectional.only(
                                  bottom: 20
                              ),
                              child: Material(
                                color: Colors.blue[800],
                                borderRadius: BorderRadius.circular(10),
                                child: InkWell(
                                  onTap: (){
                                    print(widget.statuss);
                                    DoctorCubit.get(context).GetAllNurses();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => ChatScreen(usermodel:widget.usermodel,)),
                                    );

                                  } ,
                                  child: Container(
                                      height: 40,
                                      width:  MediaQuery.of(context).size.width,
                                      child: Center(
                                          child:Text("Chat",
                                              style: Theme.of(context).textTheme.titleLarge
                                          )
                                      )),


                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                    ],
                  ),


                ],
              ),
            )

          ],
        ),
      ),
    );
  }
}



