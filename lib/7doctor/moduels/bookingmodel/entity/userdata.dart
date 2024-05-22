import 'dart:core';

class AppointmentData {

   final String ? patientname;
  final String ?doctoruuid;
  final String ?doctorname;
  final String ?userId;
  final String ?date;
  final String? time;
  final bool?isOpened;
  final String?isViewed;
  late final String ?status;
  final String ?appointmentId;


  AppointmentData(

      {
        this.patientname,
        this.doctorname,
        this.isOpened,
        this.isViewed,
        this.appointmentId,
        this.status,
        this.doctoruuid,
        this.userId,
        this.date,
        this.time,

      });
}


class AppointmentDataNerse{

  final String ?userId;
  final String ?doctorName;
  final String ?appointmentId;
  final String ?name;
  final String ?doctoruuid;
  final String ?gender;
  final double? latitude;
  final double ?longitude;
  late final String ?status;

  AppointmentDataNerse(

      {
        this.doctoruuid,
        this.appointmentId,
        this.doctorName,
        this.status,
        this.userId,
        this.name,
      this.gender,
         this.latitude,
         this.longitude,
      });
}


class NotificationDataFromNurse {
  final String userId;
  final String? name;
  final String? doctorUuid;
  final String? gender;
  final double? latitude;
  final double? longitude;
  final String? doctorName;
  final String? doctorImage;
  final String? status;

  NotificationDataFromNurse({
    required this.userId,
    this.name,
    this.doctorUuid,
    this.gender,
    this.latitude,
    this.longitude,
    this.doctorName,
    this.doctorImage,
    this.status,
  });
}



class NotificationData {
  final String ?appointmentId;
 late final bool ?isOpened;
  final bool?isViewed;
 final String ?userId;
  final String ?date;
  final String ?time;
  final String ?doctorName;
  final String? doctorImage;
  late final String ?status;

  NotificationData({
    this.appointmentId,
    this.userId,
    this.isViewed,
    this.isOpened,
    this.date,
    this.time,
    this.doctorName,
    this.doctorImage,
    this.status,
  });
}