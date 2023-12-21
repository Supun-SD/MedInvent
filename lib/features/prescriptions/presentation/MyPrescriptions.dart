import 'package:flutter/material.dart';
import 'NewPrescription_1.dart';

class MyPresContent extends StatefulWidget {
  const MyPresContent({super.key});

  @override
  State<MyPresContent> createState() => _MyPresContentState();
}

class _MyPresContentState extends State<MyPresContent> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    List<Widget> myPrescriptions = [];

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
                    : myPrescriptions,
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
                          return const AssignPrescription();
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

class Patient {
  final String name;
  final String imagePath;

  Patient({required this.name, required this.imagePath});
}

class AssignPrescription extends StatefulWidget {
  const AssignPrescription({super.key});

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
            'Add a new Prescription',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: screenHeight * 0.02,
            ),
          ),
          SizedBox(height: screenHeight * 0.025),
          Text(
            'Select the profile to add the prescription',
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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NewPrescription()),
              );
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
                "Next",
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
