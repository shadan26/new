import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:doctorproject/7doctor/cubit/cubit.dart';
import 'package:doctorproject/7doctor/cubit/state.dart';
import 'package:doctorproject/7doctor/moduels/inclincmodel/inclincscreen.dart';
import 'package:doctorproject/7doctor/moduels/messagemodel/messagedoctor.dart';
import 'package:doctorproject/7doctor/moduels/messagemodel/messagemodelscreen.dart';
import 'package:doctorproject/7doctor/moduels/messagemodel/messagenurse.dart';
import 'package:doctorproject/7doctor/moduels/nurseScreen/nurseScreen.dart';
import 'package:doctorproject/7doctor/moduels/settingmodel/settingScreen.dart';
import 'package:doctorproject/7doctor/moduels/settingmodel/settingdoctor.dart';
import 'package:doctorproject/7doctor/moduels/timemodel/timescreen.dart';
import 'package:doctorproject/models/usermodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../notfication/notficationNurse.dart';
import '../../notfication/notification.dart';
import '../../shared/shared_preferense/sharedPreferense.dart';
import '../moduels/bookingmodel/firemanger.dart';
import '../moduels/loginmodel/loginscreen.dart';
import '../moduels/nurseScreen/time/timescreen.dart';

class HomeScreenTwo extends StatefulWidget{
  @override
  State<HomeScreenTwo> createState() => _HomeScreenTwoState();
}

class _HomeScreenTwoState extends State<HomeScreenTwo> {

  int notificationCount = 0;
  @override
  void initState() {
    Appointment.instance.getUnViewedNotificationCountForAdmin().then((value) => {
      setState(() {
        notificationCount = value;
      })
    });
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DoctorCubit,DoctorState>(
      listener: (context,DoctorState){

      },
      builder: (context,DoctorState){
        var cubit=DoctorCubit.get(context);
        var modell=DoctorCubit.get(context).model;
        print(cubit.doctorHomeScreentwo.length);
        print(cubit.doctorHomeScreentwo);
        if(modell?.status=='user')
        return Scaffold(
          backgroundColor: Colors.grey[200],
          appBar: AppBar(
            elevation: 0.0,
            systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.grey[200],
                statusBarIconBrightness: Brightness.dark
            ),
            backgroundColor: Colors.grey[200],
            centerTitle: false,
            title: Text(''
                'Home Screen',
              style: TextStyle(
                color: Colors.black,
                fontSize: 30
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return NotificationUser() ;
                    },
                  )).then((value) {
                    Appointment.instance.
                    getUnViewedNotificationCountForAdmin()
                        .then((value) => {
                      setState(() {
                        notificationCount = value;
                      })
                    });
                  });
                },
                icon: Stack(
                  children: [
                    const Icon(Icons.notification_add, color: Colors.black,size: 30,),
                    if (notificationCount > 0)
                      Positioned(
                        right: 3,
                        top: 3,
                        bottom: 3,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 1,
                            minHeight: 1,
                          ),
                          child: Text(
                            notificationCount.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              IconButton(
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NotificationUserForNurse(),
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.home,
                    size: 30,
                    color: Colors.black,
                  ))
            ],
          ),
          bottomNavigationBar: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 20
              ),
              child: GNav(
                gap: 8,
                tabBackgroundColor: Colors.blue.shade800,
                activeColor: Colors.white,
                padding: EdgeInsets.all(16),
                selectedIndex: cubit.currentIndex,
                onTabChange: (index){
                  cubit.changeCureentIndex(index);
                  if(cubit.currentIndex==0){
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomeScreenTwo()), (route) => false);
                  }
                  else if(cubit.currentIndex==1){
                    cubit.getAllUsers();
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>MessageScreen()), (route) => false);
                  }
                  else if(cubit.currentIndex==2){
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>SettingScreen()), (route) => false);
                  }

                },

                tabs: [

                  GButton(
                    icon: Icons.home,
                    text: 'Home',
                  ),
                  GButton(
                    icon: Icons.chat,
                    text: 'Chat',
                  ),
                  GButton(
                    icon: Icons.person,
                    text: 'Profile',
                  ),

                ],
              ),
            ),
          ),
          body: ConditionalBuilder(
            condition:cubit.doctorHomeScreentwo.length>0 ,
            builder:(context)=> SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 35,
                          backgroundImage: NetworkImage(
                              '${modell?.image}'
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Hello ${modell?.name}',style: TextStyle(
                                  color: Colors.black,
                                fontSize: 20
                              ),
                              ),
                              SizedBox(
                                height: 5,
                              ),

                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 250,
                    child: ListView.separated(
                        physics:BouncingScrollPhysics()  ,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context,index)=>BuildOnBoardDoctor(context,cubit.doctorHomeScreentwo[index]),
                        separatorBuilder: (context,index)=>SizedBox(
                        ),
                        itemCount:cubit.doctorHomeScreentwo.length),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20
                    ),
                    child: Row(
                      children: [
                        Text(
                          'Our Services',
                          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: Colors.black
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: (){
                              cubit.getAllUsers();
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>InClinic()));
                            },
                            child: Container(
                              height: 200,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadiusDirectional.circular(20)
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image(
                                    height: 100,
                                      width: 100,
                                      image:AssetImage(
                                        'assets/images/online.png'
                                      ) ),
                                  Text(
                                    'Book A Doctor',
                                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                      color: Colors.black
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: (){
                              cubit.GetAllNurses();
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>NurseScreen()));
                            },
                            child: Container(
                              height: 200,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadiusDirectional.circular(20)
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image(
                                      height: 100,
                                      width: 100,
                                      image:AssetImage(
                                          'assets/images/doctor-consultation.png'
                                      ) ),
                                  Text(
                                    'Book A Nurse',
                                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                        color: Colors.black
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20
                    ),
                    child: Row(
                      children: [
                        Text(
                          'Recommended Doctor',
                          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: Colors.black
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 250,
                    child: ListView.builder(
                        physics:BouncingScrollPhysics()  ,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context,index)=>BuildRecommendedDoctor(context,cubit.doctorHomeScreentwo[index]),
                        itemCount:cubit.doctorHomeScreentwo.length),
                  ),

                ],
              ),
            ) ,
            fallback:(context)=>Center(child: CircularProgressIndicator()) ,
          ),
        );
        else if(modell?.status=='doctor')
          return Scaffold(
            backgroundColor: Colors.grey[200],
            appBar: AppBar(
              backgroundColor: Colors.blue[800],
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.blue[800],
                statusBarIconBrightness: Brightness.light
              ),
              title: Text(
                '7 Doctors',
                style: Theme
                    .of(context)
                    .textTheme
                    .titleLarge,
              ),
              centerTitle: false,

            ),
            body:
            ConditionalBuilder(
              condition: (modell?.name!=null && modell?.image!=null),
              builder: (context)=>SingleChildScrollView(
                physics:BouncingScrollPhysics() ,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.blue[800],
                          borderRadius: BorderRadiusDirectional.only(
                              bottomEnd: Radius.circular(20),
                              bottomStart: Radius.circular(20)
                          )
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(

                          children: [

                            CircleAvatar(
                              radius: 50,
                              backgroundImage: NetworkImage(
                                '${modell?.image}',
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Hello, ${modell?.name}',
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Hope You Are doing well',
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            child: Container(

                              child: Row(
                                children: [
                                  Image(
                                      image: AssetImage(
                                        'assets/images/calendar.png'
                                      ),
                                    width: 120,
                                    height: 120,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    'Reservations',
                                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                      color: Colors.black
                                    ),
                                  )
                                ],
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadiusDirectional.circular(20)
                              ),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                            ),
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>TimeScreen()));
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          InkWell(
                            onTap: (){
                              cubit.getAllUsers();
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>MessageDoctorScreen()));
                            },
                            child: Container(

                              child: Row(
                                children: [
                                  Image(
                                    image: AssetImage(
                                        'assets/images/doctor.png'
                                    ),
                                    width: 120,
                                    height: 120,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    'Messages',
                                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                        color: Colors.black
                                    ),
                                  )
                                ],
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadiusDirectional.circular(20)
                              ),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>SettingDoctorScreen()));
                            },
                            child: Container(

                              child: Row(
                                children: [
                                  Image(
                                    image: AssetImage(
                                        'assets/images/avatar.png'
                                    ),
                                    width: 120,
                                    height: 120,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    'Profile',
                                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                        color: Colors.black
                                    ),
                                  )
                                ],
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadiusDirectional.circular(20)
                              ),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          InkWell(
                            onTap: (){
                              SharedHelper.RemoveData(key: 'uid').then((value) {
                                if(value) {
                                  Navigator.pushAndRemoveUntil(context,
                                      MaterialPageRoute(builder: (context) =>
                                          LoginScreen()), (route) => false);


                                }



                              });
                            },
                            child: Container(

                              child: Row(
                                children: [
                                  Image(
                                    image: AssetImage(
                                        'assets/images/logout.png'
                                    ),
                                    width: 120,
                                    height: 120,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    'Log Out',
                                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                        color: Colors.black
                                    ),
                                  )
                                ],
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadiusDirectional.circular(20)
                              ),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                            ),
                          ),
                        ],
                      ),
                    ),


                  ],
                ),
              ),
              fallback: (context)=>Center(child: CircularProgressIndicator()),
            ),
          );
        else if(modell?.status=='nurse')
          return Scaffold(
            backgroundColor: Colors.grey[200],
            appBar: AppBar(
              backgroundColor: Colors.blue[800],
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.blue[800],
                statusBarIconBrightness: Brightness.light
              ),
              title: Text(
                '7 Doctors',
                style: Theme
                    .of(context)
                    .textTheme
                    .titleLarge,
              ),
              centerTitle: false,

            ),
            body: ConditionalBuilder(
              condition: (modell?.name!=null && modell?.image!=null),
              builder: (context)=>SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.blue[800],
                          borderRadius: BorderRadiusDirectional.only(
                              bottomEnd: Radius.circular(20),
                              bottomStart: Radius.circular(20)
                          )
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          children: [

                            CircleAvatar(
                              radius: 50,
                              backgroundImage: NetworkImage(
                                '${modell?.image}',
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Hello, ${modell?.name}',
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Hope You Are doing well',
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            child: Container(

                              child: Row(
                                children: [
                                  Image(
                                    image: AssetImage(
                                        'assets/images/calendar.png'
                                    ),
                                    width: 120,
                                    height: 120,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    'Reservations',
                                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                        color: Colors.black
                                    ),
                                  )
                                ],
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadiusDirectional.circular(20)
                              ),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                            ),
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>TimeScreenNurse()));
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          InkWell(
                            onTap: (){
                              cubit.getAllUsers();
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>MessageNurseScreen()));
                            },
                            child: Container(

                              child: Row(
                                children: [
                                  Image(
                                    image: AssetImage(
                                        'assets/images/doctor.png'
                                    ),
                                    width: 120,
                                    height: 120,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    'Messages',
                                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                        color: Colors.black
                                    ),
                                  )
                                ],
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadiusDirectional.circular(20)
                              ),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>SettingDoctorScreen()));
                            },
                            child: Container(

                              child: Row(
                                children: [
                                  Image(
                                    image: AssetImage(
                                        'assets/images/avatar.png'
                                    ),
                                    width: 120,
                                    height: 120,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    'Profile',
                                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                        color: Colors.black
                                    ),
                                  )
                                ],
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadiusDirectional.circular(20)
                              ),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          InkWell(
                            onTap: (){
                              SharedHelper.RemoveData(key: 'uid').then((value) {
                                if(value) {
                                  Navigator.pushAndRemoveUntil(context,
                                      MaterialPageRoute(builder: (context) =>
                                          LoginScreen()), (route) => false);


                                }



                              });
                            },
                            child: Container(

                              child: Row(
                                children: [
                                  Image(
                                    image: AssetImage(
                                        'assets/images/logout.png'
                                    ),
                                    width: 120,
                                    height: 120,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    'Log Out',
                                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                        color: Colors.black
                                    ),
                                  )
                                ],
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadiusDirectional.circular(20)
                              ),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                            ),
                          ),
                        ],
                      ),
                    ),



                  ],
                ),
              ),
              fallback: (context)=>Center(child: CircularProgressIndicator()),
            ),
          );
        else if(modell?.status=='admin')
          {
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.blue[800],
                centerTitle: false,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.blue[800],
                  statusBarIconBrightness: Brightness.light
                ),
                title: Text(
                    '${cubit.ChangeTitle[cubit.currentIndex]}'
                ),
                actions: [
                  TextButton(
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut();
                      SharedHelper.RemoveData(key: 'uid').then((value) {
                        if(value) {
                          Navigator.pushAndRemoveUntil(context,
                              MaterialPageRoute(builder: (context) =>
                                  LoginScreen()), (route) => false);


                        }



                      });



                    }
                    , child:Icon(
                    Icons.logout_outlined,
                    color:Colors.white ,
                  ),
                  )
                ],
              ),
              bottomNavigationBar: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 20
                  ),
                  child: GNav(
                    gap: 8,
                    tabBackgroundColor: Colors.blue.shade800,
                    activeColor: Colors.white,
                    padding: EdgeInsets.all(16),
                    selectedIndex: cubit.currentIndex,
                    onTabChange: (index){
                      cubit.changeCureentIndex(index);
                      if(cubit.currentIndex==1){
                        cubit.getAllUsers();
                      }
                      if(cubit.currentIndex==2)
                        cubit.getAllUsers();

                    },

                    tabs: [

                      GButton(
                        icon: Icons.add,
                        text: 'Add Doctor',
                      ),
                      GButton(
                        icon: Icons.person,
                        text: 'Users',
                      ),
                      GButton(
                        icon: Icons.person_pin,
                        text: 'Doctors',
                      ),

                    ],
                  ),
                ),
              ),
              body: cubit.ChangeScreen[cubit.currentIndex],
            );
          }
        else
          return Scaffold();

      },

    );
  }

  Widget BuildOnBoardDoctor(context,userModel usermodel)=>Padding(
    padding: const EdgeInsets.all(20.0),
    child: Column(
      children: [
        Container(
          height: 210,
          width: 390,
          padding: EdgeInsetsDirectional.all(10),
          decoration: BoxDecoration(
              color: Colors.blue[800],
              borderRadius: BorderRadiusDirectional.circular(20)
          ),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Looking For Your Desire \n Specialist Doctor ?',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: 18
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    '${usermodel.name} \n Medicine & ${usermodel.major} \n Good Health Clinic',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: 18
                    ),
                  )
                ],
              ),
              SizedBox(
                width: 15,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 80,
                      backgroundColor: Colors.blue[800],
                      child: Image(
                        image: NetworkImage(
                            '${usermodel.image}'
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    ),
  );

  Widget BuildRecommendedDoctor(context,userModel usermodel)=> Padding(
    padding: const EdgeInsets.all(20.0),
    child: Container(
      width: 350,
      height: 250,
      padding: EdgeInsetsDirectional.all(10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadiusDirectional.circular(20)
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${usermodel.name}',
                  style: TextStyle(
                      fontSize: 18
                  ),
                ),
                Text(
                  '${usermodel.major}',
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16
                  ),
                ),
                Text(
                    'Experience',
                    style: TextStyle(
                        fontSize: 18
                    )
                ),
                Text(
                    '8 Years',
                    style:TextStyle(
                        color: Colors.grey,
                        fontSize: 16
                    )
                ),
                Text(
                    'Patients',
                    style: TextStyle(
                        fontSize: 18
                    )
                ),
                Text(
                    '1.08K',
                    style:TextStyle(
                        color: Colors.grey,
                        fontSize: 16
                    )
                ),

              ],
            ),
          ),
          Expanded(
            child: Image(
                width: 150,
                height: 200,
                image:NetworkImage(
                    '${usermodel.image}'
                ) ),
          )
        ],
      ),
    ),
  );
}