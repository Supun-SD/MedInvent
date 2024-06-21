import 'package:MedInvent/features/Appointments/model/appointment.dart';
import 'package:MedInvent/features/Appointments/presentation/appointmentDetails.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UpcomingTemplate extends StatefulWidget {
  const UpcomingTemplate({required this.appointment, super.key});

  final Appointment appointment;

  @override
  State<UpcomingTemplate> createState() => _UpcomingTemplateState();
}

// cancle popup
class _UpcomingTemplateState extends State<UpcomingTemplate> {
  String convertTime(String time) {
    DateTime dateTime = DateTime.parse('1970-01-01 $time');
    String formattedTime = DateFormat('h:mm a').format(dateTime);

    return formattedTime;
  }

  @override
  Widget build(BuildContext context) {
    // screen size
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      // appointments boxes
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
            "Dr ${widget.appointment.session.doctor.fname} ${widget.appointment.session.doctor.lname}",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: screenHeight * 0.023),
          ),
          Text(
            widget.appointment.session.doctor.specialization,
            style: TextStyle(
                fontSize: screenHeight * 0.015, color: const Color(0xFF6B6B6B)),
          ),
          SizedBox(
            height: screenHeight * 0.02,
          ),
          Text(widget.appointment.session.clinic.name),
          const Divider(
            color: Color(0xFFB5B5B5),
            thickness: 1,
          ),
          SizedBox(
            height: screenHeight * 0.005,
          ),
          Row(
            children: [
              Text(widget.appointment.session.date),
              SizedBox(
                width: screenWidth * 0.1,
              ),
              Text(convertTime(widget.appointment.session.timeFrom)),
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
          Center(
              child: Button(
                  text: "More details",
                  onPressed: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AppointmentDetails(
                                    appointment: widget.appointment,
                                    type: "upcoming",
                                  )),
                        )
                      }))
        ],
      ),
    );
  }
}

class Button extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const Button({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        side: const BorderSide(
          color: Color(0xFF2980B9),
          width: 1.0,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: screenHeight * 0.005, horizontal: screenWidth * 0.05),
        child: Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF2980B9),
            fontSize: 12.0,
          ),
        ),
      ),
    );
  }
}
