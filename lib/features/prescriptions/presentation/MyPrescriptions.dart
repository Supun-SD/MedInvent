import 'package:flutter/material.dart';

class MyPresContent extends StatelessWidget {
  const MyPresContent({super.key});

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
                    onPressed: () {},
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
