import 'package:MedInvent/features/prescriptions/presentation/PrescriptionTemplate.dart';
import 'package:flutter/material.dart';

class DocPresContent extends StatelessWidget {
  final List docPrescriptions;
  const DocPresContent({required this.docPrescriptions, super.key});

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
            children: docPrescriptions.isEmpty
                ? [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: screenHeight * 0.1,
                          horizontal: screenWidth * 0.15),
                      child: Text(
                        "You don't have any doctor prescriptions",
                        style: TextStyle(
                            fontSize: screenHeight * 0.018, color: Colors.grey),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ]
                : docPrescriptions.map((e) {
                    return PrescriptionTemplate(
                      p: e,
                    );
                  }).toList(),
          ),
        ),
      ),
    );
  }
}
