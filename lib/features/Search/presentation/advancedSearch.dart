import 'package:MedInvent/config/api.dart';
import 'package:MedInvent/features/Search/models/session.dart';
import 'package:MedInvent/features/Search/data/categories.dart';
import 'package:MedInvent/features/Search/models/Doctor.dart';
import 'package:MedInvent/features/Search/presentation/appointmentConfirmation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:intl/intl.dart';

class AdvancedSearch extends StatefulWidget {
  const AdvancedSearch({required this.category, super.key});

  final String category;

  @override
  State<AdvancedSearch> createState() => _AdvancedSearchState();
}

class _AdvancedSearchState extends State<AdvancedSearch> {
  String selectedSpec = '';

  final TextEditingController _doctor = TextEditingController();
  final TextEditingController _clinic = TextEditingController();

  bool isLoading = false;

  List<Session> searchResults = [];

  @override
  void dispose() {
    _doctor.dispose();
    super.dispose();
  }

  @override
  void initState() {
    selectedSpec = widget.category;
    super.initState();
  }

  Future<void> onSearch() async {
    String formattedDate = selectedDate.toString().split(" ")[0];

    String apiUrl =
        '${ApiConfig.baseUrl}/session/get/advancedSearch?date=$formattedDate&';

    if (_doctor.text.isNotEmpty) {
      apiUrl += 'doctor=${_doctor.text}&';
    }

    if (_clinic.text.isNotEmpty) {
      apiUrl += 'clinic=${_clinic.text}&';
    }

    if (selectedSpec != "- Any specialization -") {
      apiUrl += 'specialization=$selectedSpec';
    }

    if (apiUrl.endsWith('&')) {
      apiUrl = apiUrl.substring(0, apiUrl.length - 1);
    }

    setState(() {
      isLoading = true;
    });
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);

        if (jsonResponse['data'] != null) {
          List<dynamic> resultsJson = jsonResponse['data'];
          if (resultsJson.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('No sessions available'),
                backgroundColor: Colors.redAccent,
              ),
            );
          }
          searchResults.clear();

          for (var resultJson in resultsJson) {
            Session session = Session.fromJson(resultJson);
            searchResults.add(session);
          }
        }
      } else {
        throw Exception('Failed to load results');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed getting session'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
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

  List<Doctor> suggestedDoctors = [];

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
                          controller: _doctor,
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
                          items: ["- Any specialization -", ...categories]
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
                      SizedBox(
                        height: 40,
                        child: TextField(
                          controller: _clinic,
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
                        onPressed: onSearch,
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
                Container(
                  child: isLoading
                      ? Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: screenHeight * 0.05),
                          child: const SpinKitCircle(
                            size: 40,
                            color: Colors.blue,
                          ),
                        )
                      : Column(
                          children: [
                            ...searchResults.map((result) => SearchResult(
                                  session: result,
                                ))
                          ],
                        ),
                )
              ],
            ),
          ),
        ));
  }
}

class SearchResult extends StatelessWidget {
  const SearchResult({required this.session, super.key});
  final Session session;

  String formatDate(String dateStr) {
    DateTime dateTime = DateTime.parse(dateStr);
    String daySuffix(int day) {
      if (day >= 11 && day <= 13) {
        return 'th';
      }
      switch (day % 10) {
        case 1:
          return 'st';
        case 2:
          return 'nd';
        case 3:
          return 'rd';
        default:
          return 'th';
      }
    }

    String weekday = DateFormat('EEE').format(dateTime);
    int day = dateTime.day;
    String month = DateFormat('MMMM').format(dateTime);

    return '$weekday, $day${daySuffix(day)} of $month';
  }

  String convertTime(String time) {
    DateTime dateTime = DateTime.parse('1970-01-01 $time');
    String formattedTime = DateFormat('h:mm a').format(dateTime);

    return formattedTime;
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
        ),
        width: double.infinity,
        margin: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
        padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.08, vertical: screenHeight * 0.02),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Dr ${session.doctor.fname} ${session.doctor.lname}",
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(session.doctor.specialization),
                const SizedBox(
                  height: 3,
                ),
                const Divider(
                  height: 1,
                  color: Colors.grey,
                ),
                const SizedBox(
                  height: 3,
                ),
                Text(
                  session.clinic,
                  style: const TextStyle(fontSize: 15),
                ),
                const SizedBox(
                  height: 3,
                ),
                const Divider(
                  height: 1,
                  color: Colors.grey,
                ),
                const SizedBox(
                  height: 3,
                ),
                Text(
                  "${formatDate(session.date)} | ${convertTime(session.timeFrom)}",
                  style: const TextStyle(fontSize: 15),
                ),
                const SizedBox(
                  height: 3,
                ),
                const Divider(
                  height: 1,
                  color: Colors.grey,
                ),
                const SizedBox(
                  height: 3,
                ),
                Text(
                  "Active patients : ${session.activePatients}",
                  style: const TextStyle(fontSize: 15),
                ),
              ],
            ),
            IconButton(
              onPressed: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          AppointmentConfirmation(session: session)),
                )
              },
              icon: const Icon(Icons.arrow_forward, color: Colors.grey),
            )
          ],
        ));
  }
}
