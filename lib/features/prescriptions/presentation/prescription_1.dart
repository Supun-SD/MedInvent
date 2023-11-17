import 'package:MedInvent/presentation/components/BottomNavBar.dart';
import 'package:flutter/material.dart';

class Prescriptions extends StatefulWidget {
  const Prescriptions({super.key});

  @override
  State<Prescriptions> createState() => _PrescriptionsState();
}

class _PrescriptionsState extends State<Prescriptions> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.topRight,
                colors: [
                  Color(0xFF474CA0),
                  Color(0xFF468FA0),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              title: const Text("Prescriptions"),
              elevation: 0,
              backgroundColor: Colors.transparent,
              toolbarHeight: screenHeight * 0.1,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: screenHeight * 0.85,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(screenHeight * 0.06),
                  topRight: Radius.circular(screenHeight * 0.06),
                ),
                color: Colors.white,
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.08,
                      vertical: screenHeight * 0.05),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const PrescriptionTemplate(
                          date: "2023/01/12",
                          pharmacy: "Sumudu Pharmacy",
                          doctor: "Dr Amith"),
                      SizedBox(
                        height: screenHeight * 0.03,
                      ),
                      const PrescriptionTemplate(
                          date: "2023/01/12",
                          pharmacy: "Sumudu Pharmacy",
                          doctor: "Dr Amith"),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: BottomNavBar(),
          ),
        ],
      ),
    );
  }
}

class PrescriptionTemplate extends StatefulWidget {
  final String date;
  final String doctor;
  final String pharmacy;

  const PrescriptionTemplate({
    Key? key,
    required this.date,
    required this.doctor,
    required this.pharmacy,
  }) : super(key: key);

  @override
  State<PrescriptionTemplate> createState() => _PrescriptionTemplateState();
}

class _PrescriptionTemplateState extends State<PrescriptionTemplate> {
  bool isAssigned = false;
  String assigneeName = "John Doe";
  String relationship = "Mother";
  String profilePicture = "assets/images/pic.png";

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: screenWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(screenHeight * 0.05),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 50.0,
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.07, vertical: screenHeight * 0.025),
        child: Column(
          children: [
            Visibility(
              visible: !isAssigned,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Not Assigned",
                    style: TextStyle(fontSize: screenHeight * 0.017),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        isAssigned = true;
                      });
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: const Color(0xFF2980B9),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(screenHeight * 0.05),
                      ),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                      child: Text(
                        "Assign",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: screenHeight * 0.015),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: isAssigned,
              child: Padding(
                padding: EdgeInsets.only(bottom: screenHeight * 0.02),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage(profilePicture),
                      radius: screenHeight * 0.03,
                    ),
                    SizedBox(
                      width: screenWidth * 0.05,
                    ),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            assigneeName,
                            style: TextStyle(
                                fontSize: screenHeight * 0.02,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: screenHeight * 0.005,
                          ),
                          Text(
                            relationship,
                            style: TextStyle(fontSize: screenHeight * 0.015),
                          ),
                        ]),
                  ],
                ),
              ),
            ),
            Row(children: [
              Text(
                "Fever",
                style: TextStyle(
                    fontSize: screenHeight * 0.02, fontWeight: FontWeight.bold),
              )
            ]),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: screenHeight * 0.008),
                      child: Row(
                        children: [
                          Icon(
                            Icons.calendar_month_outlined,
                            color: Colors.black45,
                            size: screenHeight * 0.025,
                          ),
                          SizedBox(
                            width: screenWidth * 0.02,
                          ),
                          Text(
                            "Date issued",
                            style: TextStyle(
                                fontSize: screenHeight * 0.015,
                                color: Colors.black45),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: screenHeight * 0.008),
                      child: Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: Colors.black45,
                            size: screenHeight * 0.025,
                          ),
                          SizedBox(
                            width: screenWidth * 0.02,
                          ),
                          Text(
                            "Pharmacy",
                            style: TextStyle(
                                fontSize: screenHeight * 0.015,
                                color: Colors.black45),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: screenHeight * 0.008),
                      child: Row(
                        children: [
                          Icon(
                            Icons.medical_services,
                            color: Colors.black45,
                            size: screenHeight * 0.025,
                          ),
                          SizedBox(
                            width: screenWidth * 0.02,
                          ),
                          Text(
                            "Doctor",
                            style: TextStyle(
                                fontSize: screenHeight * 0.015,
                                color: Colors.black45),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: screenWidth * 0.05,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: EdgeInsets.only(bottom: screenHeight * 0.015),
                        child: Text(
                          widget.date,
                          style: TextStyle(fontSize: screenHeight * 0.015),
                        )),
                    Padding(
                        padding: EdgeInsets.only(bottom: screenHeight * 0.015),
                        child: Text(
                          widget.pharmacy,
                          style: TextStyle(fontSize: screenHeight * 0.015),
                        )),
                    Padding(
                        padding: EdgeInsets.only(bottom: screenHeight * 0.015),
                        child: Text(
                          widget.doctor,
                          style: TextStyle(fontSize: screenHeight * 0.015),
                        )),
                  ],
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(screenHeight * 0.05),
                      side: const BorderSide(color: Color(0xFF2980B9)),
                    ),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                    child: Text(
                      "More details",
                      style: TextStyle(
                          color: Color(0xFF2980B9),
                          fontSize: screenHeight * 0.015),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
