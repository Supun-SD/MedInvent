import 'package:MedInvent/features/Appointments/data/pastAppointments.dart';
import 'package:MedInvent/features/Appointments/presentation/pastTemplate.dart';
import 'package:flutter/material.dart';

class Past extends StatelessWidget {
  const Past({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return pastAppointments.isNotEmpty?
      SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: screenHeight * 0.04,
          ),
          Column(
            children: pastAppointments.map((appointment) {
              return PastTemplate(
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
    ):
    const Padding(
      padding:EdgeInsets.all(100),
      child: Center(
        child: Text(
          "You don't have any past appointments",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey,),
        ),
      ),
    );
  }
}
