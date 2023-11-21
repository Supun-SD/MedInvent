import 'package:MedInvent/features/prescriptions/presentation/prescriptionDetails.dart';
import 'package:flutter/material.dart';

class DocPresContent extends StatelessWidget {
  const DocPresContent({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    List<Widget> docPrescriptions = [
      const DocPrescriptionTemplate(
          date: "2023/01/12", pharmacy: "Sumudu Pharmacy", doctor: "Dr Amith"),
    ];

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.08, vertical: screenHeight * 0.04),
        child: Padding(
          padding: EdgeInsets.only(bottom: screenHeight * 0.1),
          child: Column(
            children: docPrescriptions.isEmpty
                ? [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: screenHeight * 0.1,
                          horizontal: screenWidth * 0.15),
                      child: Text(
                        "You don't have any prescriptions",
                        style: TextStyle(
                            fontSize: screenHeight * 0.018, color: Colors.grey),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ]
                : docPrescriptions,
          ),
        ),
      ),
    );
  }
}

class DocPrescriptionTemplate extends StatefulWidget {
  final String date;
  final String doctor;
  final String pharmacy;

  const DocPrescriptionTemplate({
    Key? key,
    required this.date,
    required this.doctor,
    required this.pharmacy,
  }) : super(key: key);

  @override
  State<DocPrescriptionTemplate> createState() =>
      _DocPrescriptionTemplateState();
}

class _DocPrescriptionTemplateState extends State<DocPrescriptionTemplate> {
  bool isAssigned = false;
  String assigneeName = "John Doe";
  String relationship = "Mother";
  String profilePicture = "assets/images/pic.png";

  void updateAssignedStatus() {
    setState(() {
      isAssigned = true;
    });
  }

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
            horizontal: screenWidth * 0.07, vertical: screenHeight * 0.015),
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
                      showModalBottomSheet(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                              top: Radius.circular(screenHeight * 0.05)),
                        ),
                        context: context,
                        builder: (BuildContext context) {
                          return AssignPrescription(
                              onAssignPressed: updateAssignedStatus);
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
                      radius: screenHeight * 0.025,
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
                const Column(
                  children: [
                    Title(
                        icon: Icon(Icons.calendar_month_outlined),
                        title: "Date issued"),
                    Title(icon: Icon(Icons.location_on), title: "Pharmacy"),
                    Title(icon: Icon(Icons.person), title: "Doctor"),
                  ],
                ),
                Column(
                  children: [
                    Data(data: widget.date),
                    Data(data: widget.pharmacy),
                    Data(data: widget.doctor),
                  ],
                )
              ],
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
                          builder: (context) => const PrescriptionDetails()),
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

class Patient {
  final String name;
  final String imagePath;

  Patient({required this.name, required this.imagePath});
}

class AssignPrescription extends StatefulWidget {
  final VoidCallback onAssignPressed;

  const AssignPrescription({super.key, required this.onAssignPressed});

  @override
  AssignPrescriptionState createState() => AssignPrescriptionState();
}

class AssignPrescriptionState extends State<AssignPrescription> {
  List<Patient> patients = [
    Patient(name: 'John Doe', imagePath: 'assets/images/pic.png'),
    Patient(name: 'Amali', imagePath: 'assets/images/pic.png'),
  ];

  Patient? selectedPatient;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      height: screenHeight * 0.4,
      padding: EdgeInsets.all(screenWidth * 0.1),
      child: Column(
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: patients.map((patient) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedPatient = patient;
                  });
                },
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: patient == selectedPatient
                              ? Colors.blue
                              : Colors.transparent,
                          width: screenHeight * 0.0025,
                        ),
                      ),
                      child: CircleAvatar(
                        radius: screenHeight * 0.04,
                        backgroundColor: patient == selectedPatient
                            ? Colors.white
                            : Colors.white,
                        child: Padding(
                          padding: EdgeInsets.all(screenHeight * 0.005),
                          child: Image.asset(patient.imagePath),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    Text(
                      patient.name,
                      style: TextStyle(
                        fontSize: screenHeight * 0.014,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
          SizedBox(height: screenHeight * 0.02),
          TextButton(
            onPressed: () {
              setState(() {
                widget.onAssignPressed();
                Navigator.pop(context);
              });
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

class Title extends StatelessWidget {
  final Icon icon;
  final String title;

  const Title({Key? key, required this.icon, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      width: screenWidth * 0.3,
      height: screenHeight * 0.03,
      child: Row(
        children: [
          Icon(
            icon.icon,
            color: Colors.black45,
            size: screenHeight * 0.02,
          ),
          SizedBox(
            width: screenWidth * 0.02,
          ),
          Text(
            title,
            style: TextStyle(
                fontSize: screenHeight * 0.015, color: Colors.black45),
          ),
        ],
      ),
    );
  }
}

class Data extends StatelessWidget {
  final String data;

  const Data({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      width: screenWidth * 0.35,
      height: screenHeight * 0.03,
      child: Row(
        children: [
          Text(
            data,
            style:
                TextStyle(fontSize: screenHeight * 0.015, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
