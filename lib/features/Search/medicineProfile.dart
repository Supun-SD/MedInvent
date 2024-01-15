import 'package:MedInvent/features/Search/doctorProfile.dart';
import 'package:MedInvent/features/Search/models/medicine.dart';
import 'package:MedInvent/features/Search/models/pharmacy.dart';
import 'package:flutter/material.dart';

class MedicineProfile extends StatelessWidget {
  const MedicineProfile({required this.medicine, super.key});
  final Medicine medicine;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
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
      ),
      body: SingleChildScrollView(
        child: DefaultTabController(
          length: 2,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: CustomPaint(
                  size: Size(
                      MediaQuery.of(context).size.width, screenHeight * 0.05),
                  painter: HalfCirclePainter(),
                ),
              ),
              SizedBox(
                width: screenWidth,
                child: Column(
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                          width: screenWidth,
                          height: screenHeight * 0.3,
                        ),
                        Positioned(
                          left: screenWidth * 0.08,
                          right: screenWidth * 0.08,
                          top: screenHeight * 0.065,
                          child: Container(
                            width: screenWidth * 0.8,
                            height: screenHeight * 0.18,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.4),
                                  blurRadius: 20,
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: screenHeight * 0.08,
                                ),
                                Text(
                                  medicine.name,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: screenWidth * 0.055),
                                ),
                                SizedBox(
                                  height: screenHeight * 0.005,
                                ),
                                Text(
                                  medicine.scientificName,
                                  style: TextStyle(
                                      fontSize: screenWidth * 0.035,
                                      color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Center(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.white,
                                width: 4.0,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.6),
                                  blurRadius: 10,
                                ),
                              ],
                              borderRadius:
                                  BorderRadius.circular(screenHeight * 0.12),
                            ),
                            child: ClipOval(
                              child: Image.asset(
                                "assets/images/medicine.png",
                                height: screenHeight * 0.12,
                                width: screenHeight * 0.12,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
                      width: double.infinity,
                      child: const TabBar(
                        tabs: [
                          Tab(
                            text: 'Description',
                          ),
                          Tab(text: 'Drug Interactions'),
                        ],
                        labelColor: Colors.blue,
                        unselectedLabelColor: Colors.black,
                      ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: screenWidth * 0.09),
                      height: screenHeight * 0.5,
                      width: double.infinity,
                      child: TabBarView(
                        children: [
                          Description(
                            medicine: medicine,
                          ),
                          DrugInt(
                            medicine: medicine,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Description extends StatelessWidget {
  const Description({required this.medicine, super.key});
  final Medicine medicine;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Container(
        margin: EdgeInsets.symmetric(vertical: screenHeight * 0.05),
        child: Text(
          medicine.description,
          textAlign: TextAlign.justify,
          style: TextStyle(fontSize: screenWidth * 0.035),
        ));
  }
}

class DrugInt extends StatelessWidget {
  const DrugInt({required this.medicine, super.key});
  final Medicine medicine;
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Container(
        margin: EdgeInsets.symmetric(vertical: screenHeight * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...medicine.drugInteractions.map((e) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    e,
                    style: TextStyle(fontSize: screenWidth * 0.035),
                  ),
                ))
          ],
        ));
  }
}
