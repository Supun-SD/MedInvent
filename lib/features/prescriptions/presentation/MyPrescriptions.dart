import 'package:MedInvent/features/Profile/data/datasources/allProfiles.dart';
import 'package:MedInvent/features/Profile/data/models/familyMember.dart';
import 'package:MedInvent/features/Profile/data/models/myProfile.dart';
import 'package:MedInvent/features/prescriptions/data/myPrescriptions.dart';
import 'package:MedInvent/features/prescriptions/model/myPrescription.dart';
import 'package:MedInvent/features/prescriptions/model/newMyPrescription.dart';
import 'package:MedInvent/features/prescriptions/presentation/myPrescriptionDetails.dart';
import 'package:MedInvent/features/prescriptions/presentation/newPrescription.dart';
import 'package:flutter/material.dart';

class MyPresContent extends StatefulWidget {
  const MyPresContent({super.key});

  @override
  State<MyPresContent> createState() => _MyPresContentState();
}

class _MyPresContentState extends State<MyPresContent> {
  void updateScreen() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.08, vertical: screenHeight * 0.04),
        child: Padding(
          padding: EdgeInsets.only(bottom: screenHeight * 0.1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: myPrescriptions.isEmpty
                    ? [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: screenHeight * 0.1,
                              horizontal: screenWidth * 0.15),
                          child: Text(
                            "You don't have any custom prescriptions",
                            style: TextStyle(
                                fontSize: screenHeight * 0.018,
                                color: Colors.grey),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ]
                    : myPrescriptions.map((e) {
                        return MyPrescriptionTemplate(myPrescription: e);
                      }).toList(),
              ),
              SizedBox(
                height: screenHeight * 0.025,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      showModalBottomSheet(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                              top: Radius.circular(screenHeight * 0.05)),
                        ),
                        context: context,
                        builder: (BuildContext context) {
                          return AssignPrescription(
                            updateScreen: updateScreen,
                          );
                        },
                      );
                    },
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(screenHeight * 0.05),
                        side: const BorderSide(color: Color(0xFF2980B9)),
                      ),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                      child: Text(
                        "Add a new Prescription",
                        style: TextStyle(
                            color: const Color(0xFF2980B9),
                            fontSize: screenHeight * 0.015),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MyPrescriptionTemplate extends StatelessWidget {
  final MyPrescription myPrescription;
  const MyPrescriptionTemplate({super.key, required this.myPrescription});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      margin: EdgeInsets.only(bottom: screenHeight * 0.025),
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
            horizontal: screenWidth * 0.07, vertical: screenHeight * 0.015),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: screenHeight * 0.01, bottom: screenHeight * 0.02),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: const AssetImage("assets/images/pic.png"),
                    radius: screenHeight * 0.025,
                  ),
                  SizedBox(
                    width: screenWidth * 0.05,
                  ),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          myPrescription.assignedMember!.name,
                          style: TextStyle(
                              fontSize: screenHeight * 0.02,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: screenHeight * 0.005,
                        ),
                        if (myPrescription.assignedMember is FamilyMember)
                          Text(
                            myPrescription.assignedMember!.relationship,
                            style: TextStyle(fontSize: screenHeight * 0.015),
                          ),
                      ]),
                ],
              ),
            ),
            Row(children: [
              Text(
                myPrescription.title,
                style: TextStyle(
                    fontSize: screenHeight * 0.02, fontWeight: FontWeight.bold),
              )
            ]),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            Row(
              children: [
                SizedBox(
                  width: screenWidth * 0.35,
                  child: Row(
                    children: [
                      Icon(
                        Icons.calendar_month,
                        size: screenWidth * 0.045,
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Date created",
                        style: TextStyle(fontSize: screenWidth * 0.035),
                      )
                    ],
                  ),
                ),
                Text(
                  myPrescription.dateIssued,
                  style: TextStyle(
                      fontSize: screenWidth * 0.035,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
            SizedBox(
              height: screenHeight * 0.015,
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MyPrescriptionDetails(
                                prescription: myPrescription,
                              )),
                    );
                  },
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
                          color: const Color(0xFF2980B9),
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

class AssignPrescription extends StatefulWidget {
  final VoidCallback updateScreen;
  const AssignPrescription({super.key, required this.updateScreen});

  @override
  AssignPrescriptionState createState() => AssignPrescriptionState();
}

class AssignPrescriptionState extends State<AssignPrescription> {
  var selectedProfile;
  NewMyPrescription newPrescription = NewMyPrescription();

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      padding: EdgeInsets.all(screenWidth * 0.1),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            'Assign the prescription',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: screenHeight * 0.02,
            ),
          ),
          SizedBox(height: screenHeight * 0.025),
          Text(
            'Select the Patient’s Profile to assign this prescription',
            style: TextStyle(
              fontSize: screenHeight * 0.018,
            ),
          ),
          SizedBox(height: screenHeight * 0.025),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: allProfiles.map((selected) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedProfile = selected;
                      });
                    },
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: selected == selectedProfile
                                  ? Colors.blue
                                  : Colors.transparent,
                              width: screenHeight * 0.0025,
                            ),
                          ),
                          child: CircleAvatar(
                            radius: screenHeight * 0.04,
                            backgroundColor: selected == selectedProfile
                                ? Colors.white
                                : Colors.white,
                            child: Padding(
                              padding: EdgeInsets.all(screenHeight * 0.005),
                              child: Image.asset("assets/images/pic.png"),
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        selected is MyProfile
                            ? Text(
                                "Myself",
                                style: TextStyle(
                                  fontSize: screenHeight * 0.014,
                                ),
                              )
                            : Text(
                                selected.name.split(" ")[0],
                                style: TextStyle(
                                  fontSize: screenHeight * 0.014,
                                ),
                              ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          SizedBox(height: screenHeight * 0.02),
          TextButton(
            onPressed: () {
              if (selectedProfile != null) {
                newPrescription.assignedMember = selectedProfile;
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NewPrescription(
                        newPrescription: newPrescription,
                        updatePresScreen: widget.updateScreen),
                  ),
                );
              }
            },
            style: TextButton.styleFrom(
              backgroundColor: const Color(0xFF2980B9),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(screenHeight * 0.05),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
              child: Text(
                "Assign",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: screenHeight * 0.018,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
