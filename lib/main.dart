import 'package:doctorproject/7doctor/cubit/cubit.dart';
import 'package:doctorproject/7doctor/homescreen/homescreen.dart';
import 'package:doctorproject/7doctor/homescreen/homescreentwo.dart';
import 'package:doctorproject/7doctor/moduels/chatModel/chatScreen.dart';
import 'package:doctorproject/7doctor/moduels/loginmodel/logincubit/cubit.dart';
import 'package:doctorproject/7doctor/moduels/loginmodel/loginscreen.dart';
import 'package:doctorproject/7doctor/moduels/registermodel/registercubit/cubit.dart';
import 'package:doctorproject/7doctor/moduels/registermodel/registerscreen.dart';
import 'package:doctorproject/7doctor/moduels/settingmodel/settingScreen.dart';
import 'package:doctorproject/7doctor/onBoarding/onBoarding.dart';
import 'package:doctorproject/firebase_options.dart';
import 'package:doctorproject/shared/constants/blocobserver.dart';
import 'package:doctorproject/shared/constants/constants.dart';
import 'package:doctorproject/shared/shared_preferense/sharedPreferense.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'map_screen.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  print('Handling a background message ${message.messageId}');
}
late AndroidNotificationChannel channel;

bool isFlutterLocalNotificationsInitialized = false;

Future<void> setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }
  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
    'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  /// Create an Android Notification Channel.
  ///
  /// We use this channel in the `AndroidManifest.xml` file to override the
  /// default FCM channel to enable heads up notifications.
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  isFlutterLocalNotificationsInitialized = true;
}
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications',
    importance: Importance.high,
  ));

  // var token=await FirebaseMessaging.instance.getToken();
  // print(token);
  // FirebaseMessaging.onMessage.listen((event) {
  //   print(event.data.toString());
  // });
  await SharedHelper.init();
  Bloc.observer=MyBlocObserver();
  Widget widget=OnBoardingScreen();
  dynamic isOnBoard=SharedHelper.getData(key: 'onBoard');
  uid=SharedHelper.getData(key: 'uid');
  role=SharedHelper.getData(key: 'role');
 // SharedHelper.RemoveData(key: 'uid');
 // SharedHelper.RemoveData(key: 'role');
  //SharedHelper.RemoveData(key: 'onBoard');

  print(uid);
  print(isOnBoard);
  print(role);
   if(isOnBoard!=null){
     if(uid!=null) {
       widget = HomeScreenTwo();
     }
     else
       widget=LoginScreen();
   }
   else
     {
       widget=OnBoardingScreen();
     }
  runApp(MyApp(
    onBoardScreen: isOnBoard,
    StartWidget: widget,
  ));
}
class MyApp extends StatefulWidget{
  dynamic onBoardScreen;
  Widget ?StartWidget;
  MyApp({
    bool ?onBoardScreen,
    Widget ?StartWidget
}){
    this.onBoardScreen=onBoardScreen;
    this.StartWidget=StartWidget;

  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              icon: 'launch_background',
            ),
          ),
        );
      }
    });

  }
  @override
  Widget build(BuildContext context) {
    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   print("Foreground message received: ${message.notification?.body}");}
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context)=>DoctorCubit()..getUserData()),
        BlocProvider(create: (BuildContext context)=>LoginCubit()),


      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
            appBarTheme: AppBarTheme(
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                  statusBarIconBrightness: Brightness.dark

                ),
                centerTitle: true,
                color: Colors.blue,
                elevation: 0,
                titleTextStyle: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                )
            ),
            textTheme: TextTheme(
                titleLarge: TextStyle(
                    color: Colors.white
                ),
                titleSmall: TextStyle(
                    color: Colors.white
                )
            ),
            fontFamily: 'Janna',
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.blue,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.white,
            )
        ),
        home:widget.StartWidget,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

