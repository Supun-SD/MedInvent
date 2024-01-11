import 'package:MedInvent/features/Appointments/data/upcomingAppointments.dart';
import 'package:MedInvent/features/Appointments/presentation/upcomingTemplate.dart';
import 'package:flutter/material.dart';

class Upcoming extends StatelessWidget {
  const Upcoming({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return upcomingAppointments.isNotEmpty
        ? SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: screenHeight * 0.04,
                ),
                Column(
                  children: upcomingAppointments.map((appointment) {
                    return UpcomingTemplate(
                      doctor: appointment.doctor,
                      speciality: appointment.speciality,
                      hospital: appointment.hospital,
                      date: appointment.date,
                      time: appointment.time,
                      isRefundable: appointment.isRefundable,
                      cancelled: appointment.cancelled,
                    );
                  }).toList(),
                ),
                SizedBox(
                  height: screenHeight * 0.04,
                ),
              ],
            ),
          )
        : const Padding(
            padding: EdgeInsets.all(100),
            child: Center(
              child: Text(
                textAlign: TextAlign.center,
                "You dont have any upcoming appointmets",
                style: TextStyle(color: Colors.grey),
              ),
            ),
          );
  }
}
