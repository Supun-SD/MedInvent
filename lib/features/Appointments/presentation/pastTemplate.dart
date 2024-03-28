import 'package:flutter/material.dart';

class PastTemplate extends StatelessWidget {
  PastTemplate(
      {required this.doctor,
      required this.speciality,
      required this.hospital,
      required this.date,
      required this.time,
      required this.isRefundable,
      required this.cancelled,
      super.key});

  String doctor;
  String speciality;
  String hospital;
  String date;
  String time;
  bool isRefundable;
  bool cancelled;

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
            doctor,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: screenHeight * 0.023),
          ),
          Text(
            speciality,
            style: TextStyle(
                fontSize: screenHeight * 0.015, color: const Color(0xFF6B6B6B)),
          ),
          SizedBox(
            height: screenHeight * 0.02,
          ),
          Text(hospital),
          const Divider(
            color: Color(0xFFB5B5B5),
            thickness: 1,
          ),
          SizedBox(
            height: screenHeight * 0.005,
          ),
          Row(
            children: [
              Text(date),
              SizedBox(
                width: screenWidth * 0.1,
              ),
              Text(time),
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
          if (cancelled)
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
          else
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
        ],
      ),
    );
  }
}
