import 'package:MedInvent/components/sideNavBar.dart';
import 'package:MedInvent/features/prescriptions/presentation/DocPrescriptions.dart';
import 'package:MedInvent/features/prescriptions/presentation/MyPrescriptions.dart';
import 'package:MedInvent/components/CustomTabBar.dart';
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
      drawer: const SideNavBar(),
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
        title: const Text("Prescriptions"),
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
        child: Container(
          margin: EdgeInsets.only(top: screenHeight * 0.025),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50.0),
                topRight: Radius.circular(50.0),
              )),
          child: Padding(
            padding: EdgeInsets.only(top: screenHeight * 0.035),
            child: const CustomTabBar(
                tabTitles: ["Doctor's Prescriptions", "My Prescriptions"],
                tabViews: [DocPresContent(), MyPresContent()]),
          ),
        ),
      ),
    );
  }
}
