import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

import '../../../firebase_options.dart';

import 'entity/userdata.dart';

class Appointment {
  Appointment._privateConstructor();
  static final Appointment _instance = Appointment._privateConstructor();
  static Appointment get instance => _instance;
  Future<void> bookAppointment(AppointmentData data) async {
    var parentDocRef =
    FirebaseFirestore.instance.collection("users").doc(data.doctoruuid);

    CollectionReference subCollectionRef =
    parentDocRef.collection('appointment');
    var newDocRef = await subCollectionRef.add({
      'patientname':data.patientname,
      'doctorname': data.doctorname,
      'userId': data.userId,
      'time': data.time,
      'date': data.date,
      'status': data.status,
    });

    String appointmentId = newDocRef.id;
    await newDocRef.update({'appointmentId': appointmentId});
  }

  Future<void> bookAppointmentnurse(AppointmentDataNerse data) async {
    var parentDocRef =
    FirebaseFirestore.instance.collection("users").doc("ygsiBi8mpQdQGLWtXu6Joa2w2mw1");

    CollectionReference subCollectionRef =
    parentDocRef.collection('appointments');
    var newDocRef = await subCollectionRef.add({
      'userId': data.userId,
      'name': data.name,
      'longitude': data.longitude,
      'latitude': data.latitude,
      'gender': data.gender,
      'status':data.status
    });

    String appointmentId = newDocRef.id;
    await newDocRef.update({'appointmentId': appointmentId});
  }

  Future<void> updateAppointmentStatusForNurse(
      String appointmentId, String status) async {
    var doctorId = FirebaseAuth.instance.currentUser?.uid;
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(doctorId)
          .collection('appointments')
          .doc(appointmentId)
          .update({'status': status});
    } on PlatformException catch (e) {
      if (e.code == 'not-found') {
        print('Document not found.');
      } else {
        print('Error sending notification: $e');
      }
    } catch (e) {
      print('Error sending notification: $e');
    }
  }

  Future<void> saveToUserNotificationsFromNurse(
      AppointmentDataNerse data, String status) async {
    var parentDocRef =
    FirebaseFirestore.instance.collection("users").doc(data.userId);

    CollectionReference subCollectionRef =
    parentDocRef.collection('notification');
    var docRef = subCollectionRef.doc();
    subCollectionRef.add({
      'name': data.name,
      'longitude': data.longitude,
      'latitude': data.latitude,
      'status': status,
      'appointmentId': docRef.id
    });
  }

  Future<void> saveToUserNotifications(
      AppointmentData data, String status) async {
    var parentDocRef =
    FirebaseFirestore.instance.collection("users").doc(data.userId);

    CollectionReference subCollectionRef =
    parentDocRef.collection('notifications');
    var docRef = subCollectionRef.doc();
    var userId = FirebaseAuth.instance.currentUser?.uid;
    subCollectionRef.add({
      "isViewed":false,
      "isOpened": false,
      "doctorname":data.doctorname,
      'time': data.time,
      'date': data.date,
      'status': status,
      'appointmentId': docRef.id,
      'doctorId': userId
    });
  }


  Future<List<NotificationData>> getTOUserNotification(
      AppointmentData data) async {
    List<NotificationData> notificationDataList = [];
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      CollectionReference userCollectionRef = firestore.collection('users');

      QuerySnapshot subcollectionSnapshot = await userCollectionRef
          .doc(data.userId)
          .collection('notifications')
          .get();

      var doctorId = subcollectionSnapshot.docs.first['doctorId'];
      var doctorCollectionRef =
      await firestore.collection('users').doc(doctorId).get();
      var doctorData = doctorCollectionRef.data();
      var doctorImage = doctorData?['image'];
      var doctorName = doctorData?['name'];

      // class named NotificationData contains ( date, time, status, doctorName, doctorImage )
      subcollectionSnapshot.docs.forEach((DocumentSnapshot document) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;

        var status = data['status'];
        var date = data['date'];
        var time = data['time'];
        var appointmentId=data["appointmentId"];
        var isOpened = data['isOpened'] as bool;
        var isViewed = data['isViewed'] as bool;

        NotificationData notificationData = NotificationData(
            date: date,
            time: time,
            status: status,
            doctorName: doctorName,
            doctorImage: doctorImage,
        isViewed: isViewed, isOpened: isOpened,
        appointmentId: appointmentId);

        notificationDataList.add(notificationData);
      });
    } catch (e) {
      print('Error fetching subcollection data: $e');
    }
    return notificationDataList;
  }

  Future<List<NotificationDataFromNurse>> getTOUserNotificationFromNurse(
      AppointmentDataNerse data) async {
    List<NotificationDataFromNurse> notificationDataList = [];
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      CollectionReference userCollectionRef = firestore.collection('users');

      QuerySnapshot subcollectionSnapshot = await userCollectionRef
          .doc(data.userId)
          .collection('notification')
          .get();

      var doctorCollectionRef =
      await firestore.collection('users').doc(data.doctoruuid).get();
      var doctorData = doctorCollectionRef.data();
      var doctorImage = doctorData?['image'];
      var doctorName = doctorData?['name'];

      // class named NotificationData contains ( date, time, status, doctorName, doctorImage )
      subcollectionSnapshot.docs.forEach((DocumentSnapshot document) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;

        var status = data['status'];
        var name= data['name'];
        var latitude= data['latitude'];

        var longitude = data['longitude'];

        NotificationDataFromNurse notificationData = NotificationDataFromNurse (
            name: name,
            latitude:latitude ,
            longitude: longitude,
            status: status,
            doctorName: doctorName,
            doctorImage: doctorImage, userId: '');

        notificationDataList.add(notificationData);
      });
    } catch (e) {
      print('Error fetching subcollection data: $e');
    }
    return notificationDataList;
  }

  Future<List<AppointmentDataNerse>> getBookAppointmentDataForNurse(
      AppointmentDataNerse data) async {
    List<AppointmentDataNerse> appointmentDataList = [];
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      CollectionReference doctorLoginCollectionRef =
      firestore.collection('users');

      QuerySnapshot subcollectionSnapshot = await doctorLoginCollectionRef
          .doc(data.userId)
          .collection('appointments')
          .get();

      for (var document in subcollectionSnapshot.docs) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        AppointmentDataNerse appointmentData = AppointmentDataNerse(
            userId: data['userId'],
            name: data['name'],
            gender: data['gender'],
            status: data['status'],
            latitude: data['latitude'],
            longitude: data['longitude'],
            appointmentId: data['appointmentId']);

        appointmentDataList.add(appointmentData);
      }
    } catch (e) {
      print('Error fetching subcollection data: $e');
    }
    return appointmentDataList;
  }

  Future<List<AppointmentData>> getBookAppointmentData(
      AppointmentData data) async {
    List<AppointmentData> appointmentDataList = [];
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      CollectionReference doctorLoginCollectionRef =
      firestore.collection('users');

      QuerySnapshot subcollectionSnapshot = await doctorLoginCollectionRef
          .doc(data.userId)
          .collection('appointment')
          .get();

      subcollectionSnapshot.docs.forEach((DocumentSnapshot document) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        AppointmentData appointmentData = AppointmentData(

             patientname: data['patientname'],
            userId: data['userId'],
            date: data['date'],
            time: data['time'],
            status: data['status'],
            appointmentId: data['appointmentId']);

        appointmentDataList.add(appointmentData);
      });
    } catch (e) {
      print('Error fetching subcollection data: $e');
    }
    return appointmentDataList;
  }

  Future<void> sendNotification(String userId) async {
    try {
      var userDataSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (userDataSnapshot.exists) {
        var userData = userDataSnapshot.data();
        var token = userData?['token'];

        var payload = {
          'notification': {
            'title': 'Notification Title',
            'body': 'Notification Body',
          },
          'data': {
            'click_action': 'NOTIFICATION_CLICK',
          },
          'token': token,
        };

        var jsonPayload = jsonEncode(payload);

        var response = await http.post(
          Uri.parse('YOUR_API_ENDPOINT_URL'),
          headers: {'Content-Type': 'application/json'},
          body: jsonPayload,
        );

        if (response.statusCode == 200) {
          print('Notification sent successfully!');
        } else {
          print(
              'Failed to send notification. Status code: ${response.statusCode}');
        }
      } else {
        print('User document not found in Firestore.');
      }
    } catch (e) {
      print('Error sending notification: $e');
    }
  }

  Future<void> sendPushNotificationTopic(String token) async {
    try {
      final response = await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization':
          'key=AAAA_JynLIg:APA91bE5t8aBdqoZNZwiyPF1Yh6x_tWnm_12r1RWTiDxr2LNp02VecCcm7-g9qu-S6G_hVH1Qa0xQRpJQK1KO00C6BaQ24QLMW-vYYVcK_9JlVR3lVHnjLMEIc1qPl75qtdfvgLH9GAQ',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{
              'body': "7 doctor",
              'title': 'YOU HAVE A NEW ORDER',
            },
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'id': '1',
              'status': 'done'
            },
            'to': token,
            // 'to': '/topics/$topicName',
            //'token': authorizedSupplierTokenId
          },
        ),
      );
      if (kDebugMode) {
        print("response = ${response.body}");
      }
      if (kDebugMode) {
        print("response = ${response.statusCode}");
      }
    } catch (e) {
      e;
    }
  }

  Future<void> sendPushNotification(String token) async {
    try {
      final response = await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization':
          'key=AAAA_JynLIg:APA91bE5t8aBdqoZNZwiyPF1Yh6x_tWnm_12r1RWTiDxr2LNp02VecCcm7-g9qu-S6G_hVH1Qa0xQRpJQK1KO00C6BaQ24QLMW-vYYVcK_9JlVR3lVHnjLMEIc1qPl75qtdfvgLH9GAQ',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{
              'body': "7 doctor",
              'title': 'YOU HAVE A NEW MESSAGES',
            },
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'id': '1',
              'status': 'done'
            },
            'to': token,
            // 'to': '/topics/$topicName',
            //'token': authorizedSupplierTokenId
          },
        ),
      );
      if (kDebugMode) {
        print("response = ${response.body}");
      }
      if (kDebugMode) {
        print("response = ${response.statusCode}");
      }
    } catch (e) {
      e;
    }
  }

  Future<void> updateAppointmentStatus(
      String appointmentId, String status) async {
    var doctorId = FirebaseAuth.instance.currentUser?.uid;
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(doctorId)
          .collection('appointment')
          .doc(appointmentId)
          .update({'status': status});
    } on PlatformException catch (e) {
      if (e.code == 'not-found') {
        print('Document not found.');
      } else {
        print('Error sending notification: $e');
      }
    } catch (e) {
      print('Error sending notification: $e');
    }
  }

  Future<String?> getToken() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    String? token = await FirebaseMessaging.instance.getToken();

    if (kDebugMode) {
      print("Token = $token");
    }
    return token;
  }

  Future<int> getUnViewedNotificationCountForAdmin() async {
    var userId = FirebaseAuth.instance.currentUser?.uid;
    var ref = FirebaseFirestore.instance.collection("users").doc(userId).collection("notifications");
    QuerySnapshot querySnapshot =
    await ref.where("isViewed", isEqualTo: false).get();
    var numberOfUnOpenedNotifications = querySnapshot.docs.length;
    return numberOfUnOpenedNotifications;
  }

  Future<void> readNotification(String appointmentId) async {
    var userId = FirebaseAuth.instance.currentUser?.uid;
    var ref = FirebaseFirestore.instance.collection("users").doc(userId).collection("notifications");
    QuerySnapshot querySnapshot =
    await ref
        .where("appointmentId", isEqualTo: appointmentId)
        .get();
    await querySnapshot.docs.first.reference.update({'isOpened': true});
  }

  Future<void> viewNotifications() async {
    var userId = FirebaseAuth.instance.currentUser?.uid;
    var querySnapshot = await FirebaseFirestore.instance.collection("users").doc(userId).collection("notifications").get();
    for (var element in querySnapshot.docs) {
      element.reference.update({'isViewed': true});
    }
  }

}
