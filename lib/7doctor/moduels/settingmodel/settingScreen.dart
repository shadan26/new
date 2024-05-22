import 'package:doctorproject/7doctor/cubit/cubit.dart';
import 'package:doctorproject/7doctor/cubit/state.dart';
import 'package:doctorproject/7doctor/homescreen/homescreen.dart';
import 'package:doctorproject/7doctor/homescreen/homescreentwo.dart';
import 'package:doctorproject/7doctor/moduels/editProfile/editScreen.dart';
import 'package:doctorproject/7doctor/moduels/loginmodel/logincubit/cubit.dart';
import 'package:doctorproject/7doctor/moduels/loginmodel/loginscreen.dart';
import 'package:doctorproject/7doctor/moduels/messagemodel/messagemodelscreen.dart';
import 'package:doctorproject/7doctor/moduels/profileInfo/profileInfoScreen.dart';
import 'package:doctorproject/7doctor/moduels/timemodel/timescreen.dart';
import 'package:doctorproject/models/usermodel.dart';
import 'package:doctorproject/shared/constants/constants.dart';
import 'package:doctorproject/shared/shared_preferense/sharedPreferense.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class SettingScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DoctorCubit,DoctorState>(
      listener: (context,DoctorState){

      },
      builder: (context,DoctorState){
        DoctorCubit cubit=DoctorCubit.get(context);
        var modell=DoctorCubit.get(context).model;
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            centerTitle: false,
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.blue[800],
              statusBarIconBrightness: Brightness.light
            ),
            backgroundColor: Colors.blue[800],
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
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsetsDirectional.only(
                  start: 20
                ),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.blue[800]
                ),
                child: Text(
                  'Setting',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Colors.white,
                    fontSize: 30

                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Account',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Colors.black
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileInfo()));

                        },
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(
                                '${modell!.image}'
                              ),
                              radius: 40,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${modell!.name}',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 20
                                    ),
                                  ),
                                  Text(
                                    '${modell.uid}',

                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 18
                                    ),
                                  ),

                                ],
                              ),
                            ),
                            Spacer(),
                            Icon(
                              Icons.chevron_right,
                              color: Colors.blue[800],
                              size: 40,
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Container(
                        height: 1,
                        width: double.infinity,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      /////////////////////////////////////////////////
                      Text(
                        'Setting',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Colors.black
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>EditProfileScreen()));
                        },
                        child: Row(
                          children: [
                           CircleAvatar(
                             child: Icon(
                               Icons.edit,
                               color: Colors.white,
                             ),
                             backgroundColor: Colors.blue[800],
                             radius: 27,
                           ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Edit Profile'
                            ),
                            Spacer(),
                            Icon(
                              Icons.chevron_right,
                              color: Colors.blue[800],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          CircleAvatar(
                            child: Icon(
                              Icons.help,
                              color: Colors.white,
                            ),
                            backgroundColor: Colors.blue[800],
                            radius: 27,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                              'Help Center'
                          ),
                          Spacer(),
                          Icon(
                              Icons.chevron_right,
                            color: Colors.blue[800],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          CircleAvatar(
                            child: Icon(
                              Icons.error,
                              color: Colors.white,
                            ),
                            backgroundColor: Colors.blue[800],
                            radius: 27,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                              'About Us'
                          ),
                          Spacer(),
                          Icon(
                              Icons.chevron_right,
                            color: Colors.blue[800],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      InkWell(
                        onTap: ()async{
                        await FirebaseAuth.instance.signOut();
                          SharedHelper.RemoveData(key: 'uid').then((value) {
                            if(value) {
                              Navigator.pushAndRemoveUntil(context,
                                  MaterialPageRoute(builder: (context) =>
                                      LoginScreen()), (route) => false);


                            }



                          });
                        },
                        child: Row(
                          children: [
                            CircleAvatar(
                              child: Icon(
                                Icons.logout_outlined,
                                color: Colors.white,
                              ),
                              backgroundColor: Colors.blue[800],
                              radius: 27,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                                'Log Out'
                            ),
                            Spacer(),
                            Icon(
                                Icons.chevron_right,
                              color: Colors.blue[800],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )





            ],
          ),

        );
      },
    );

  }

}