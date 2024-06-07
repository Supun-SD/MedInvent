import 'package:MedInvent/features/Profile/data/datasources/allProfiles.dart';
import 'package:MedInvent/features/Profile/data/models/Profile.dart';
import 'package:MedInvent/features/Profile/data/models/familyMember.dart';
import 'package:MedInvent/features/Profile/data/models/myProfile.dart';
import 'package:MedInvent/features/prescriptions/model/Prescription.dart';
import 'package:MedInvent/features/prescriptions/presentation/prescriptionDetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//Widget to display individual prescription details
class PrescriptionTemplate extends StatefulWidget {
  final Prescription p;

  const PrescriptionTemplate({super.key, required this.p});

  @override
  State<PrescriptionTemplate> createState() => _PrescriptionTemplateState();
}

// State class for DocPrescriptionTemplate
class _PrescriptionTemplateState extends State<PrescriptionTemplate> {
  String profilePicture = "assets/images/pic.png";

  // Method to update the UI with assigned member information
  void updateUI(Profile fm) {
    setState(() {
      widget.p.assignedTo = fm;
    });
  }

  // Method to update the UI after details screen is updated
  void updateFromDetailsScreen() {
    setState(() {});
  }

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
            // Display assigned member information or assign button
            widget.p.assignedTo != null
                ? Padding(
                    padding: EdgeInsets.only(
                        top: screenHeight * 0.01, bottom: screenHeight * 0.02),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage(profilePicture),
                          radius: screenHeight * 0.025,
                        ),
                        SizedBox(
                          width: screenWidth * 0.05,
                        ),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.p.assignedTo!.name,
                                style: TextStyle(
                                    fontSize: screenHeight * 0.02,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: screenHeight * 0.005,
                              ),
                              if (widget.p.assignedTo is FamilyMember)
                                Text(
                                  widget.p.assignedTo!.relationship,
                                  style:
                                      TextStyle(fontSize: screenHeight * 0.015),
                                ),
                            ]),
                      ],
                    ),
                  )
                : Row(
                    children: [
                      Text(
                        "Not Assigned",
                        style: TextStyle(fontSize: screenHeight * 0.017),
                      ),
                      const Spacer(),
                      // Button to assign prescription
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
                                prescription: widget.p,
                                onAssignPressed: (Profile selectedProfile) {
                                  updateUI(selectedProfile);
                                },
                              );
                            },
                          );
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: const Color(0xFF2980B9),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(screenHeight * 0.05),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.02),
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

            // Display prescription title, date issued, doctor, and more details button
            Row(children: [
              Text(
                widget.p.presName,
                style: TextStyle(
                    fontSize: screenHeight * 0.02, fontWeight: FontWeight.bold),
              )
            ]),
            SizedBox(
              height: screenHeight * 0.02,
            ),

            // Display date issued
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
                        widget.p.createdBy == "doctor"
                            ? "Date issued"
                            : "Date created",
                        style: TextStyle(fontSize: screenWidth * 0.035),
                      )
                    ],
                  ),
                ),
                Text(
                  widget.p.createdAt.split('T')[0],
                  style: TextStyle(
                      fontSize: screenWidth * 0.035,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),

            // Display doctor
            SizedBox(
              height: screenHeight * 0.015,
            ),
            if (widget.p.createdBy == "doctor")
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: screenWidth * 0.35,
                    child: Row(
                      children: [
                        Icon(
                          Icons.account_circle_outlined,
                          size: screenWidth * 0.045,
                          color: Colors.grey,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Doctor",
                          style: TextStyle(fontSize: screenWidth * 0.035),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Text(
                      widget.p.doctorName,
                      style: TextStyle(
                          fontSize: screenWidth * 0.035,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),

            SizedBox(
              height: screenHeight * 0.02,
            ),

            // Button to navigate to prescription details screen
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PrescriptionDetails(
                                prescription: widget.p,
                                updatePrescriptionsScreen:
                                    updateFromDetailsScreen,
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

// Widget for assigning prescriptions to profiles
class AssignPrescription extends ConsumerStatefulWidget {
  final Prescription prescription;
  final Function(Profile) onAssignPressed;

  const AssignPrescription({
    super.key,
    required this.prescription,
    required this.onAssignPressed,
  });

  @override
  ConsumerState<AssignPrescription> createState() => AssignPrescriptionState();
}

// State class for AssignPrescription
class AssignPrescriptionState extends ConsumerState<AssignPrescription> {
  var selectedProfile;

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

          // Button to assign prescription to selected profile
          TextButton(
            onPressed: () {
              setState(() {
                widget.prescription.assignedTo = selectedProfile;
              });
              widget.onAssignPressed(selectedProfile);
              Navigator.pop(context);
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