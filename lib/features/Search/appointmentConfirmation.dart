import 'package:MedInvent/features/Search/models/appointment.dart';
import 'package:flutter/material.dart';

class AppointmentConfirmation extends StatelessWidget {
  const AppointmentConfirmation(
      {required this.appointment, required this.doctor, super.key});
  final Appointment appointment;
  final String doctor;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      blurRadius: 20,
                    ),
                  ],
                ),
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.05,
                    vertical: screenHeight * 0.035),
                margin: EdgeInsets.symmetric(
                    horizontal: screenHeight * 0.05,
                    vertical: screenHeight * 0.03),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Appointment details",
                      style: TextStyle(
                          fontSize: screenWidth * 0.04,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text("Doctor's name",
                        style: TextStyle(fontSize: screenWidth * 0.03)),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      doctor,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: screenWidth * 0.035),
                    ),
                    const Divider(
                      color: Colors.grey,
                    ),
                    Text("Clinic",
                        style: TextStyle(fontSize: screenWidth * 0.03)),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(appointment.clinic,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: screenWidth * 0.035)),
                    const Divider(
                      color: Colors.grey,
                    ),
                    Text("Date and time",
                        style: TextStyle(fontSize: screenWidth * 0.03)),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text(appointment.date,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: screenWidth * 0.035)),
                        const Spacer(),
                        Text(appointment.time,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: screenWidth * 0.035)),
                      ],
                    ),
                    const Divider(
                      color: Colors.grey,
                    ),
                    Text("Appointment No.",
                        style: TextStyle(fontSize: screenWidth * 0.03)),
                    const SizedBox(
                      height: 5,
                    ),
                    Text((appointment.activePatients + 1).toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: screenWidth * 0.04)),
                    const Divider(
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.12),
                width: double.infinity,
                height: screenHeight * 0.05,
                child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    backgroundColor: const Color(0xFF2980B9),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  child: Text(
                    "Pay",
                    style: TextStyle(
                        fontSize: screenWidth * 0.04,
                        color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
