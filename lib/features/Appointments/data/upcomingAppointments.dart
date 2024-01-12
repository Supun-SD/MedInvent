import 'package:MedInvent/features/Appointments/model/appointment.dart';

List<Appointment> upcomingAppointments = [
  Appointment(
      doctor: "William Perera",
      speciality: "Neurologist",
      hospital: "Medicare - Katubedda",
      date: "2024/01/13",
      time: "8.30PM",
      isRefundable: true,
      cancelled: false),
  Appointment(
      doctor: "Albert Einstein",
      speciality: "Cardiologist",
      hospital: "Asiri Hospital",
      date: "2024/01/31",
      time: "5.30PM",
      isRefundable: true,
      cancelled: true),
  Appointment(
      doctor: "Stephen Strange",
      speciality: "Physician",
      hospital: "Asiri Hospital",
      date: "2024/02/05",
      time: "2.30PM",
      isRefundable: false,
      cancelled: true),
];
