class Appointment {
  Appointment(this.clinic,this.date, this.time, this.activePatients,this.maximumPatients, this.channelingFee,
      this.specialNote);

  String clinic;
  String date;
  String time;
  int activePatients;
  int maximumPatients;
  double channelingFee;
  String? specialNote;
}
