import 'package:flutter/material.dart';

class UpcomingTemplate extends StatelessWidget {
  UpcomingTemplate(
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
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.only(
          left: screenWidth * 0.1,
          right: screenWidth * 0.1,
          top: screenWidth * 0.035),
      padding: EdgeInsets.all(screenHeight * 0.025),
      decoration: BoxDecoration(
        color: const Color(0xFFE3E3E3),
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
            color: Colors.grey,
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
            color: Colors.grey,
            thickness: 1,
          ),
          SizedBox(
            height: screenHeight * 0.01,
          ),
          if (isRefundable)
            if (!cancelled)
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: screenWidth * 0.015),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.cancel_outlined,
                        color: Colors.redAccent,
                        size: 18, // Icon color
                      ),
                      SizedBox(width: 10.0),
                      Text(
                        "Cancel appointment",
                        style: TextStyle(
                          color: Colors.black, // Font color
                        ),
                      ),
                    ],
                  ),
                ),
              )
            else
              const Text(
                "Cancelled",
                style: TextStyle(color: Colors.redAccent),
              )
          else
            const Text(
              "Cancellation not allowed for this appointment.",
              style: TextStyle(color: Colors.grey),
            )
        ],
      ),
    );
  }
}
