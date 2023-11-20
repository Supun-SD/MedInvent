import 'package:MedInvent/features/prescriptions/presentation/DocPrescriptions.dart';
import 'package:MedInvent/features/prescriptions/presentation/MyPrescriptions.dart';
import 'package:MedInvent/features/prescriptions/presentation/prescriptionDetails.dart';
import 'package:MedInvent/presentation/components/BottomNavBar.dart';
import 'package:MedInvent/presentation/components/CustomTabBar.dart';
import 'package:flutter/material.dart';

class Prescriptions extends StatefulWidget {
  const Prescriptions({super.key});

  @override
  State<Prescriptions> createState() => _PrescriptionsState();
}

class _PrescriptionsState extends State<Prescriptions> {
  @override
  Widget build(BuildContext context) {
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
                child: Padding(
                  padding: EdgeInsets.only(top: screenHeight * 0.04),
                  child: const CustomTabBar(tabTitles: [
                    "Doctor's Prescriptions",
                    "My Prescriptions"
                  ], tabViews: [
                    DocPresContent(),
                    MyPresContent()
                  ]),
                )),
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
