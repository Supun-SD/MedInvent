import 'package:MedInvent/features/Search/models/Doctor.dart';

class Session {
  String sessionId;
  String date;
  String timeFrom;
  String timeTo;
  int noOfPatients;
  int activePatients;
  double docFee;
  double clinicFee;
  bool isRefundable;
  bool isArrived;
  bool isCancelled;
  String clinicId;
  String doctorId;
  Doctor doctor;
  String clinic;

  Session({
    required this.sessionId,
    required this.date,
    required this.timeFrom,
    required this.timeTo,
    required this.noOfPatients,
    required this.activePatients,
    required this.docFee,
    required this.clinicFee,
    required this.isRefundable,
    required this.isArrived,
    required this.isCancelled,
    required this.clinicId,
    required this.doctorId,
    required this.doctor,
    required this.clinic,
  });

  factory Session.fromJson(Map<String, dynamic> json) {
    return Session(
      sessionId: json['session_id'],
      date: json['date'],
      timeFrom: json['timeFrom'],
      timeTo: json['timeTo'],
      noOfPatients: json['noOfPatients'],
      activePatients: json['activePatients'],
      docFee: double.parse(json['docFee']),
      clinicFee: double.parse(json['clinicFee']),
      isRefundable: json['isRefundable'],
      isArrived: json['isArrived'],
      isCancelled: json['isCancelled'],
      clinicId: json['clinic_id'],
      doctorId: json['doctor_id'],
      doctor: Doctor.fromJson(json['doctor']),
      clinic: (json['clinic']['name']),
    );
  }
}
