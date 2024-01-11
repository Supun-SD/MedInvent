import 'package:MedInvent/features/Appointments/model/appointment.dart';

List<Appointment> upcomingAppointments = [
  Appointment(
      doctor: "Dr Stephen Strange",
      speciality: "Neurologist",
      hospital: "Asiri Hospital",
      date: "2024-01-13",
      time: "8.30PM",
      isRefundable: true,
      cancelled: false),
  Appointment(
      doctor: "Dr Stephen Strange",
      speciality: "Cardiologist",
      hospital: "Asiri Hospital",
      date: "2024-01-13",
      time: "8.30PM",
      isRefundable: true,
      cancelled: true),
  Appointment(
      doctor: "Dr Stephen Strange",
      speciality: "Neurologist",
      hospital: "Asiri Hospital",
      date: "2024-01-13",
      time: "8.30PM",
      isRefundable: false,
      cancelled: true),
];
