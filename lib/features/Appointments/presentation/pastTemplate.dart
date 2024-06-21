import 'package:MedInvent/features/Appointments/model/appointment.dart';
import 'package:MedInvent/features/Appointments/presentation/appointmentDetails.dart';
import 'package:MedInvent/features/Appointments/presentation/upcomingTemplate.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PastTemplate extends StatelessWidget {
  const PastTemplate({required this.appointment, super.key});

  final Appointment appointment;

  String convertTime(String time) {
    DateTime dateTime = DateTime.parse('1970-01-01 $time');
    String formattedTime = DateFormat('h:mm a').format(dateTime);

    return formattedTime;
  }

  @override
  Widget build(BuildContext context) {
    // getting screen size
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    // appointments boxes
    return Container(
      margin: EdgeInsets.only(
          left: screenWidth * 0.1,
          right: screenWidth * 0.1,
          top: screenWidth * 0.035),
      padding: EdgeInsets.all(screenHeight * 0.025),
      decoration: BoxDecoration(
        color: const Color(0xFFEDEDED),
        borderRadius: BorderRadius.circular(screenWidth * 0.07),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Dr ${appointment.session.doctor.fname} ${appointment.session.doctor.lname}",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: screenHeight * 0.023),
          ),
          Text(
            appointment.session.doctor.specialization,
            style: TextStyle(
                fontSize: screenHeight * 0.015, color: const Color(0xFF6B6B6B)),
          ),
          SizedBox(
            height: screenHeight * 0.02,
          ),
          Text(appointment.session.clinic.name),
          const Divider(
            color: Color(0xFFB5B5B5),
            thickness: 1,
          ),
          SizedBox(
            height: screenHeight * 0.005,
          ),
          Row(
            children: [
              Text(appointment.session.date),
              SizedBox(
                width: screenWidth * 0.1,
              ),
              Text(convertTime(appointment.session.timeFrom)),
            ],
          ),
          SizedBox(
            height: screenHeight * 0.005,
          ),
          const Divider(
            color: Color(0xFFB5B5B5),
            thickness: 1,
          ),
          SizedBox(
            height: screenHeight * 0.01,
          ),
          if (appointment.isCancelled)
            const Row(
              children: [
                Icon(
                  Icons.cancel,
                  color: Colors.redAccent,
                  size: 15,
                ),
                SizedBox(
                  width: 10,
                ),
                Text("Cancelled")
              ],
            )
          else if (appointment.isAttended)
            const Row(
              children: [
                Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 15,
                ),
                SizedBox(
                  width: 10,
                ),
                Text("Attended")
              ],
            )
          else
            const Row(
              children: [
                Icon(
                  Icons.check_circle,
                  color: Colors.red,
                  size: 15,
                ),
                SizedBox(
                  width: 10,
                ),
                Text("Not attended")
              ],
            ),
          SizedBox(
            height: screenHeight * 0.02,
          ),
          Center(
              child: Button(
                  text: "More details",
                  onPressed: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AppointmentDetails(
                                    appointment: appointment,
                                    type: "past",
                                  )),
                        )
                      }))
        ],
      ),
    );
  }
}
