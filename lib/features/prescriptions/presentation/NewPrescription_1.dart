import 'package:MedInvent/components/BottomNavBar.dart';
import 'package:flutter/material.dart';

import 'NewPrescription_2.dart';

class NewPrescription extends StatefulWidget {
  const NewPrescription({super.key});

  @override
  State<NewPrescription> createState() => NewPrescriptionState();
}

class NewPrescriptionState extends State<NewPrescription> {
  static List<Medicine> medicineList = [
    Medicine(image: "assets/images/drugs.png", medName: "Amlodipine"),
    Medicine(image: "assets/images/drugs.png", medName: "Acetaminophen"),
    Medicine(image: "assets/images/drugs.png", medName: "Bisoprolol"),
    Medicine(image: "assets/images/drugs.png", medName: "Cetirizine"),
    Medicine(image: "assets/images/drugs.png", medName: "Clonidine"),
    Medicine(image: "assets/images/drugs.png", medName: "Enalapril"),
    Medicine(image: "assets/images/drugs.png", medName: "Heparinoid"),
    Medicine(image: "assets/images/drugs.png", medName: "Panadol"),
  ];

  List<Medicine> displayMedicine = List.from(medicineList);

  void updateList(String value) {
    setState(() {
      if (value.isEmpty) {
        displayMedicine = List.from(medicineList);
      } else {
        displayMedicine = medicineList
            .where((medicine) =>
                medicine.medName.toLowerCase().contains(value.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
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
              title: const Text("Add medicine"),
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
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                child: Column(
                  children: [
                    SizedBox(
                      height: screenHeight * 0.05,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.4),
                            spreadRadius: 0,
                            blurRadius: 30,
                          ),
                        ],
                      ),
                      child: TextField(
                        onChanged: (value) {
                          updateList(value);
                        },
                        style: const TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide.none,
                          ),
                          hintText: "Search the medicine",
                          prefixIcon: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.0),
                            child: Icon(Icons.search),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: displayMedicine.isEmpty
                          ? Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: screenHeight * 0.2),
                              child: Text(
                                "No result found",
                                style: TextStyle(
                                    fontSize: screenWidth * 0.035,
                                    color: Colors.grey),
                              ),
                            )
                          : ListView.builder(
                              itemCount: displayMedicine.length * 2 - 1,
                              itemBuilder: (context, index) {
                                if (index.isOdd) {
                                  return const Divider(
                                    color: Colors.grey,
                                    height: 1,
                                  );
                                }
                                final medicineIndex = index ~/ 2;

                                return ListTile(
                                  onTap: () => {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const MedicineDetails()),
                                    )
                                  },
                                  title: Text(
                                      displayMedicine[medicineIndex].medName),
                                  leading: Image.asset(
                                    displayMedicine[medicineIndex].image,
                                    height: screenHeight * 0.05,
                                  ),
                                );
                              },
                            ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Medicine {
  String image;
  String medName;

  Medicine({required this.image, required this.medName});
}
