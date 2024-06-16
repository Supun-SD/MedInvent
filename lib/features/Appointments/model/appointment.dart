class Appointment {
  String appointmentId;
  bool isCancelled;
  String? cancelledByType;
  String? cancelledById;
  bool isPaid;
  bool isAttended;
  String userId;
  String patientTitle;
  String patientName;
  String contactNo;
  String? email;
  String area;
  String nic;
  int appointmentNo;
  Session session;

  Appointment({
    required this.appointmentId,
    required this.isCancelled,
    this.cancelledByType,
    this.cancelledById,
    required this.isPaid,
    required this.isAttended,
    required this.userId,
    required this.patientTitle,
    required this.patientName,
    required this.contactNo,
    required this.email,
    required this.area,
    required this.nic,
    required this.appointmentNo,
    required this.session,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      appointmentId: json['appointment_id'],
      isCancelled: json['isCancelled'],
      cancelledByType: json['cancelledByType'],
      cancelledById: json['cancelledById'],
      isPaid: json['isPaid'],
      isAttended: json['isAttended'],
      userId: json['user_id'],
      patientTitle: json['patientTitle'],
      patientName: json['patientName'],
      contactNo: json['contactNo'],
      email: json['email'],
      area: json['area'],
      nic: json['nic'],
      appointmentNo: json['appointmentNo'],
      session: Session.fromJson(json['session']),
    );
  }
}

class Session {
  String date;
  String timeFrom;
  String timeTo;
  double docFee;
  double clinicFee;
  Doctor doctor;
  Clinic clinic;

  Session({
    required this.date,
    required this.timeFrom,
    required this.timeTo,
    required this.docFee,
    required this.clinicFee,
    required this.doctor,
    required this.clinic,
  });

  factory Session.fromJson(Map<String, dynamic> json) {
    return Session(
      date: json['date'],
      timeFrom: json['timeFrom'],
      timeTo: json['timeTo'],
      docFee: double.parse(json['docFee']),
      clinicFee: double.parse(json['clinicFee']),
      doctor: Doctor.fromJson(json['doctor']),
      clinic: Clinic.fromJson(json['clinic']),
    );
  }
}

class Doctor {
  String fname;
  String mname;
  String lname;
  String specialization;

  Doctor({
    required this.fname,
    required this.mname,
    required this.lname,
    required this.specialization,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      fname: json['fname'],
      mname: json['mname'],
      lname: json['lname'],
      specialization: json['specialization'],
    );
  }
}

class Clinic {
  String name;

  Clinic({
    required this.name,
  });

  factory Clinic.fromJson(Map<String, dynamic> json) {
    return Clinic(
      name: json['name'],
    );
  }
}
