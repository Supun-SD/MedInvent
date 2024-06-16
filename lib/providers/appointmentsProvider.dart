import 'package:MedInvent/features/Appointments/model/appointment.dart';
import 'package:MedInvent/features/login/data/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

import '../config/api.dart';

class AppointmentsState {
  final List<Appointment> upcomingAppointments;
  final List<Appointment> pastAppointments;
  final bool isLoading;

  AppointmentsState({
    required this.upcomingAppointments,
    required this.pastAppointments,
    required this.isLoading,
  });

  factory AppointmentsState.initial() {
    return AppointmentsState(
      upcomingAppointments: [],
      pastAppointments: [],
      isLoading: false,
    );
  }
}

class AppointmentsNotifier extends StateNotifier<AppointmentsState> {
  AppointmentsNotifier() : super(AppointmentsState.initial());

  Future<void> fetchAppointments(BuildContext context, String userID) async {
    String apiUrl = '${ApiConfig.baseUrl}/appointment/get/user/all/$userID';
    state = AppointmentsState(
      upcomingAppointments: state.upcomingAppointments,
      pastAppointments: state.pastAppointments,
      isLoading: true,
    );

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);

        if (jsonResponse['data'] != null) {
          List<dynamic> appointmentsJson = jsonResponse['data'];

          List<Appointment> upcomingAppointments = [];
          List<Appointment> pastAppointments = [];

          for (var json in appointmentsJson) {
            Appointment appointment = Appointment.fromJson(json);
            if (checkAppointmentStatus(
                    appointment.session.date, appointment.session.timeTo) ==
                'upcoming') {
              upcomingAppointments.add(appointment);
            } else if (checkAppointmentStatus(
                    appointment.session.date, appointment.session.timeTo) ==
                'past') {
              pastAppointments.add(appointment);
            }
          }

          state = AppointmentsState(
            upcomingAppointments: upcomingAppointments,
            pastAppointments: pastAppointments,
            isLoading: false,
          );
        }
      } else {
        throw Exception('Failed to load appointments');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to get appointments.'),
          backgroundColor: Colors.red,
        ),
      );
      state = AppointmentsState(
        upcomingAppointments: state.upcomingAppointments,
        pastAppointments: state.pastAppointments,
        isLoading: false,
      );
    }
  }

  Future<void> createAppointment(
      BuildContext context,
      String sessionId,
      String patientName,
      String mobileNo,
      String email,
      String title,
      String nic,
      String area,
      User user,
      String forWhom) async {
    String apiUrl = '${ApiConfig.baseUrl}/appointment/newappointment';

    Doctor doctor = Doctor(
        fname: "Stephen",
        mname: "Alexander",
        lname: "Strange",
        specialization: "Physician");
    Clinic clinic = Clinic(name: "Health Care Clinic");
    Session session = Session(
        date: "2024-12-12",
        timeFrom: "14:00:00",
        timeTo: "16:30:00",
        docFee: 2200.00,
        clinicFee: 850.00,
        doctor: doctor,
        clinic: clinic);

    try {
      final response = await http.post(Uri.parse(apiUrl),
          headers: {
            'Content-Type': 'application/json',
          },
          body: json.encode({
            'user_id': user.userId,
            'session_id': sessionId,
            'patientTitle': title,
            'patientName': forWhom == 'Other'
                ? patientName
                : '${user.fname} ${user.lname}',
            'contactNo': forWhom == 'Other'
                ? convertMobileNumber(mobileNo)
                : user.mobileNo,
            'email': forWhom == 'Other' ? email : user.email,
            'area': forWhom == 'Other' ? area : user.patientAddress.city,
            'nic': forWhom == 'Other' ? nic : user.nic,
          }));

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        var data = jsonResponse['data'];

        state = AppointmentsState(
          pastAppointments: state.pastAppointments,
          upcomingAppointments: [
            Appointment(
                appointmentId: data['appointment_id'],
                isCancelled: data['isCancelled'],
                isPaid: data['isPaid'],
                isAttended: data['isAttended'],
                userId: data['user_id'],
                patientTitle: data['patientTitle'],
                patientName: data['patientName'],
                contactNo: data['contactNo'],
                email: email,
                area: area,
                nic: nic,
                appointmentNo: data['appointmentNo'],
                session: session),
            ...state.upcomingAppointments
          ],
          isLoading: false,
        );
      } else {
        throw Exception('Failed booking the appointment');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed booking the appointment.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> cancelAppointment(
      Appointment appointment, String userId, BuildContext context) async {
    String apiUrl =
        '${ApiConfig.baseUrl}/appointment/update/cancel/${appointment.appointmentId}';

    Map<String, String> data = {
      'cancelledByType': 'user',
      'cancelledById': userId,
    };
    var body = json.encode(data);

    state = AppointmentsState(
      upcomingAppointments: state.upcomingAppointments,
      pastAppointments: state.pastAppointments,
      isLoading: true,
    );

    try {
      final response = await http.put(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: body,
      );

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        appointment.isCancelled = true;
        appointment.cancelledByType = 'user';
        appointment.cancelledById = userId;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Appointment cancelled successfully'),
            backgroundColor: Colors.red,
          ),
        );
      } else {
        throw Exception('Failed to cancel the appointment');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed cancelling the appointment'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      state = AppointmentsState(
        upcomingAppointments: state.upcomingAppointments,
        pastAppointments: state.pastAppointments,
        isLoading: false,
      );
    }
  }
}

final appointmentsProvider =
    StateNotifierProvider<AppointmentsNotifier, AppointmentsState>(
  (ref) => AppointmentsNotifier(),
);

// Function to check if appointment is past or upcoming
String checkAppointmentStatus(String date, String endTime) {
  DateTime appointmentDateTime = DateTime.parse('$date $endTime');
  DateTime now = DateTime.now();
  if (appointmentDateTime.isBefore(now)) {
    return 'past';
  } else {
    return 'upcoming';
  }
}

String convertMobileNumber(String number) {
  return '+94${number.substring(1)}';
}
