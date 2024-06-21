import 'package:MedInvent/providers/authProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BasicInfo extends ConsumerWidget {
  const BasicInfo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    var user = ref.watch(userProvider)!;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF474CA0),
                Color(0xFF468FA0),
              ],
            ),
          ),
        ),
        title: const Text("Basic Information"),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF474CA0),
              Color(0xFF468FA0),
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top: screenHeight * 0.025),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50.0),
                  topRight: Radius.circular(50.0),
                )),
            child: Container(
              margin: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.07,
                  vertical: screenHeight * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: CircleAvatar(
                      radius: screenHeight * 0.065,
                      backgroundImage:
                          const AssetImage('assets/images/pic.png'),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.03,
                  ),
                  Text(
                    "Basic Information",
                    style: TextStyle(
                        fontSize: screenHeight * 0.025,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.02,
                        horizontal: screenWidth * 0.02),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 0,
                          blurRadius: 70,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Info(
                          label: "First Name",
                          data: user.fname,
                        ),
                        Info(
                          label: "Last Name",
                          data: user.lname,
                        ),
                        Info(
                          label: "NIC",
                          data: user.nic,
                        ),
                        Info(
                          label: "Date of Birth",
                          data: user.dob,
                        ),
                        Info(
                          label: "Gender",
                          data: user.gender,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.03,
                  ),
                  Text(
                    "Secondary Information",
                    style: TextStyle(
                        fontSize: screenHeight * 0.025,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.02,
                        horizontal: screenWidth * 0.02),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 0,
                          blurRadius: 70,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Info(
                          label: "Address Line 1",
                          data: user.patientAddress.lineOne,
                        ),
                        Info(
                          label: "Address Line 2",
                          data: user.patientAddress.lineTwo == null
                              ? user.patientAddress.lineTwo!
                              : "-",
                        ),
                        Info(
                          label: "City",
                          data: user.patientAddress.city,
                        ),
                        Info(
                          label: "District",
                          data: user.patientAddress.district,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.09,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Info extends StatelessWidget {
  const Info({required this.label, required this.data, super.key});

  final String label, data;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.all(screenWidth * 0.03),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
              width: 1.0,
            ),
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          width: double.infinity,
          padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.05, vertical: screenHeight * 0.02),
          child: Text(data, style: TextStyle(fontSize: screenWidth * 0.04)),
        ),
        Positioned(
          top: 0,
          left: 25,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 4),
            decoration: const BoxDecoration(
              color: Color(0xFFF2F2F2),
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Text(
              label,
              style: TextStyle(
                fontSize: screenWidth * 0.035,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
