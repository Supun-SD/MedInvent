class Appointment {
  String doctor;

  Appointment(
      {required this.doctor,
      required this.speciality,
      required this.hospital,
      required this.date,
      required this.time,
      required this.isRefundable,
      required this.cancelled});

  String speciality;
  String hospital;
  String date;
  String time;
  bool isRefundable;
  bool cancelled;
}
