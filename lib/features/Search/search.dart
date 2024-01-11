import 'package:flutter/material.dart';

import 'package:MedInvent/components/sideNavBar.dart';
import 'package:MedInvent/features/Search/advancedSearch.dart';
import 'package:MedInvent/features/Search/data/doctors.dart';
import 'package:MedInvent/features/Search/data/pharmacies.dart';
import 'package:MedInvent/features/Search/models/categories.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String selectedValue = 'Doctors';

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      drawer: const SideNavBar(),
      appBar: AppBar(
        elevation: 0,
        title: const Text('Search'),
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
        child: SizedBox(
          height: screenHeight,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  width: double.infinity,
                  height: screenHeight * 0.06,
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
              Positioned(
                top: screenHeight * 0.02,
                left: 0,
                right: 0,
                child: Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.05),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.4),
                          blurRadius: 30,
                          offset: const Offset(0, 15)),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Center(
                            child: DropdownButton<String>(
                              value: selectedValue,
                              items: <String>[
                                'Doctors',
                                'Pharmacies',
                                'Medicine'
                              ].map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.only(left: 15),
                                    child: Text(
                                      value,
                                      style: TextStyle(
                                          fontSize: screenWidth * 0.035),
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedValue = newValue!;
                                });
                              },
                              underline: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.transparent),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0),
                              color: Colors.grey[200],
                            ),
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Search for $selectedValue',
                                hintStyle: TextStyle(
                                    fontSize: screenWidth * 0.035),
                                border: InputBorder.none,
                                icon: const Icon(Icons.search),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: screenHeight * 0.12,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.only(left: screenWidth * 0.06),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Categories",
                        style: TextStyle(
                            fontSize: screenWidth * 0.05,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: screenHeight * 0.02,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: Categories.values.map((category) {
                            return Category(
                                category:
                                    category.toString().split('.').last);
                          }).toList(),
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.025,
                      ),
                      Text(
                        "Nearby Doctors",
                        style: TextStyle(
                            fontSize: screenWidth * 0.05,
                            fontWeight: FontWeight.bold),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: doctors.map((doctor) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: screenHeight * 0.02),
                              child: NearbyDoctor(
                                  doctorName: doctor.name,
                                  speciality: doctor.speciality),
                            );
                          }).toList(),
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.015,
                      ),
                      Text(
                        "Nearby Pharmacies",
                        style: TextStyle(
                            fontSize: screenWidth * 0.05,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: screenHeight * 0.025,
                      ),
                      ...pharmacies
                          .map((p) => NearbyPharmacy(
                              name: p.name, mobileNo: p.contact))
                          .toList(),
                      SizedBox(
                        height: screenHeight * 0.1,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Category extends StatelessWidget {
  const Category({required this.category, super.key});

  final String category;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AdvancedSearch(category: category)),
        );
      },
      child: Container(
        margin: EdgeInsets.only(right: screenWidth * 0.03),
        height: screenHeight * 0.08,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            const Color(0xFF1578B6).withOpacity(0.67),
            const Color(0xFF626599),
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.035),
            child: Text(
              category,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}

class NearbyDoctor extends StatelessWidget {
  const NearbyDoctor(
      {required this.doctorName, required this.speciality, super.key});

  final String doctorName;
  final Categories speciality;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return InkWell(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.only(right: screenWidth * 0.03),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 10,
                offset: const Offset(5, 0)),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Column(
            children: [
              Image.asset(
                'assets/images/doctor.jpg',
                height: screenHeight * 0.15,
              ),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    doctorName,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth * 0.028),
                  ),
                  SizedBox(
                    height: screenHeight * 0.005,
                  ),
                  Text(
                    speciality.toString().split('.').last,
                    style: TextStyle(fontSize: screenWidth * 0.025),
                  )
                ],
              ),
              SizedBox(
                height: screenHeight * 0.02,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class NearbyPharmacy extends StatelessWidget {
  const NearbyPharmacy({required this.name, required this.mobileNo, super.key});

  final String name;
  final String mobileNo;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      margin: EdgeInsets.only(
          right: screenWidth * 0.06, bottom: screenHeight * 0.015),
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 15,
          ),
        ],
      ),
      child: Row(
        children: [
          Text(name),
          const Spacer(),
          Row(
            children: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.location_on_outlined)),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.call_outlined)),
            ],
          )
        ],
      ),
    );
  }
}
