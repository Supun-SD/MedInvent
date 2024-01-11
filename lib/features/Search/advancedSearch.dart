import 'package:MedInvent/features/Search/data/doctors.dart';
import 'package:MedInvent/features/Search/doctorProfile.dart';
import 'package:MedInvent/features/Search/models/categories.dart';
import 'package:MedInvent/features/Search/models/doctor.dart';
import 'package:flutter/material.dart';

class AdvancedSearch extends StatefulWidget {
  const AdvancedSearch({required this.category, super.key});

  final String category;

  @override
  State<AdvancedSearch> createState() => _AdvancedSearchState();
}

class _AdvancedSearchState extends State<AdvancedSearch> {
  String selectedSpec = 'Select the specialization';
  String selectedClinic = 'Select a clinic';

  final List<String> categories = [
    'Select the specialization',
    ...Categories.values.map((category) => category.name).toList(),
  ];

  final List<String> clinics = [
    'Select a clinic',
    'Clinic 1',
    'Clinic 2',
    'Clinic 3',
    'Clinic 4',
    'Clinic 5',
  ];

  @override
  void initState() {
    selectedSpec = widget.category;
    super.initState();
  }

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  List<Doctor> suggestedDoctors = [
    doctors[0],
    doctors[1],
    doctors[2],
    doctors[3]
  ];

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.08, vertical: screenHeight * 0.01),
            child: Column(
              children: [
                Center(
                    child: Text(
                  "Find your doctor",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth * 0.05),
                )),
                SizedBox(
                  height: screenHeight * 0.03,
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.05,
                      vertical: screenHeight * 0.03),
                  width: double.infinity,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15, bottom: 5),
                        child: Text(
                          "Doctor's name",
                          style: TextStyle(fontSize: screenWidth * 0.035),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                        child: TextField(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[200],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.0),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.0),
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 1),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.0),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 7.5, horizontal: 15),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.02,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, bottom: 5),
                        child: Text(
                          "Specialization",
                          style: TextStyle(fontSize: screenWidth * 0.035),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: DropdownButton<String>(
                          items: categories
                              .map((String item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(item),
                                  ))
                              .toList(),
                          underline: const SizedBox(),
                          icon: const Icon(Icons.arrow_drop_down,
                              color: Colors.grey),
                          style: const TextStyle(color: Colors.black),
                          dropdownColor: Colors.grey[200],
                          borderRadius: BorderRadius.circular(20.0),
                          value: selectedSpec,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedSpec = newValue!;
                            });
                          },
                          isExpanded: true,
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.02,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, bottom: 5),
                        child: Text(
                          "Clinic",
                          style: TextStyle(fontSize: screenWidth * 0.035),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: DropdownButton<String>(
                          items: clinics
                              .map((String item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(item),
                                  ))
                              .toList(),
                          underline: const SizedBox(),
                          icon: const Icon(Icons.arrow_drop_down,
                              color: Colors.grey),
                          style: const TextStyle(color: Colors.black),
                          dropdownColor: Colors.grey[200],
                          borderRadius: BorderRadius.circular(20.0),
                          value: selectedClinic,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedClinic = newValue!;
                            });
                          },
                          isExpanded: true,
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.02,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, bottom: 5),
                        child: Text(
                          "Date",
                          style: TextStyle(fontSize: screenWidth * 0.035),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              '${selectedDate.toLocal()}'.split(' ')[0],
                            ),
                            const Spacer(),
                            IconButton(
                              onPressed: () => _selectDate(context),
                              icon: const Icon(
                                Icons.calendar_month,
                                size: 20,
                                color: Colors.blueGrey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.02,
                      ),
                      Center(
                          child: TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          backgroundColor: const Color(0xFF2980B9),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 30.0,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        child: const Text(
                          "Search",
                          style: TextStyle(color: Colors.white),
                        ),
                      )),
                    ],
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.025,
                ),
                ...suggestedDoctors
                    .map((e) =>
                        SuggestedDoctors(doctor: e))
                    .toList(),
                SizedBox(
                  height: screenHeight * 0.025,
                ),
              ],
            ),
          ),
        ));
  }
}

class SuggestedDoctors extends StatelessWidget {
  const SuggestedDoctors({required this.doctor,super.key});
  final Doctor doctor;
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Container(
        margin: EdgeInsets.only(bottom: screenHeight * 0.015),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
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
        child: Row(
          children: [
            Image.asset(
              'assets/images/pic.png',
              width: screenWidth * 0.12,
            ),
            const SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Dr ${doctor.name}",
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold),
                ),
                Text(
                  doctor.speciality.name,
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                )
              ],
            ),
            const Spacer(),
            Container(
              width: 36.0,
              height: 36.0,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF2980B9),
              ),
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DoctorProfile(doctor: doctor)),
                  );
                },
                icon: const Icon(Icons.person_2_outlined,
                    color: Colors.white, size: 18),
                padding: const EdgeInsets.all(8.0),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Container(
              width: 36.0,
              height: 36.0,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF2980B9),
              ),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.calendar_month,
                    color: Colors.white, size: 18),
                padding: const EdgeInsets.all(8.0),
              ),
            ),
          ],
        ));
  }
}
