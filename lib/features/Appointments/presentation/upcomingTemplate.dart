import 'package:flutter/material.dart';

class UpcomingTemplate extends StatefulWidget {
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
  State<UpcomingTemplate> createState() => _UpcomingTemplateState();
}

class _UpcomingTemplateState extends State<UpcomingTemplate> {
  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          title: const Text("Confirmation"),
          content: const Text("Are you sure you want to cancel this appointment?"),
          actions: [
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Confirm"),
              onPressed: () {
                setState(() {
                  widget.cancelled = true;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

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
        color: const Color(0xFFEDEDED),
        borderRadius: BorderRadius.circular(screenWidth * 0.07),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.doctor,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: screenHeight * 0.023),
          ),
          Text(
            widget.speciality,
            style: TextStyle(
                fontSize: screenHeight * 0.015, color: const Color(0xFF6B6B6B)),
          ),
          SizedBox(
            height: screenHeight * 0.02,
          ),
          Text(widget.hospital),
          const Divider(
            color: Color(0xFFB5B5B5),
            thickness: 1,
          ),
          SizedBox(
            height: screenHeight * 0.005,
          ),
          Row(
            children: [
              Text(widget.date),
              SizedBox(
                width: screenWidth * 0.1,
              ),
              Text(widget.time),
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
          if (widget.isRefundable)
            if (!widget.cancelled)
              TextButton(
                onPressed: () {
                  _showConfirmationDialog(context);
                },
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
