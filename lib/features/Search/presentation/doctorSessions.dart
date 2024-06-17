import 'package:MedInvent/features/Search/models/session.dart';
import 'package:MedInvent/features/Search/presentation/appointmentConfirmation.dart';
import 'package:MedInvent/features/Search/presentation/doctorProfile.dart';
import 'package:MedInvent/features/Search/models/Doctor.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DoctorSessions extends StatefulWidget {
  const DoctorSessions(
      {required this.sessions, required this.doctor, super.key});

  final List<Session> sessions;
  final Doctor doctor;
  @override
  State<DoctorSessions> createState() => _DoctorSessionsState();
}

class _DoctorSessionsState extends State<DoctorSessions> {
  String selectedValue = 'All Clinics';
  DateTime selectedDate = DateTime.now();

  List<String> clinics = [];

  late List<Session> filteredSessions;

  @override
  void initState() {
    super.initState();
    initClinicsSelectList();
    filteredSessions = [...widget.sessions];
  }

  void initClinicsSelectList() {
    final uniqueClinics = <String>{};
    for (final session in widget.sessions) {
      final clinicName = session.clinic;
      if (clinicName != null) {
        uniqueClinics.add(clinicName);
      }
    }

    clinics = ['All Clinics', ...uniqueClinics.toList()];
  }

  void filterSessions() {
    setState(() {
      filteredSessions = widget.sessions
          .where((session) =>
              selectedValue == 'All Clinics' || session.clinic == selectedValue)
          .where((session) =>
              session.date == DateFormat('yyyy-MM-dd').format(selectedDate))
          .toList();
    });
  }

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
        filterSessions();
      });
    }
  }

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
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: CustomPaint(
                painter: HalfCirclePainter(),
              ),
            ),
            Column(
              children: [
                Stack(
                  children: [
                    SizedBox(
                      width: screenWidth,
                      height: screenHeight * 0.15,
                    ),
                    Positioned(
                      left: screenWidth * 0.08,
                      right: screenWidth * 0.08,
                      top: screenHeight * 0.01,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                blurRadius: 20,
                                offset: const Offset(0, 10)),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/images/pic.png",
                              height: screenHeight * 0.075,
                            ),
                            SizedBox(
                              width: screenWidth * 0.05,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Dr ${widget.doctor.fname} ${widget.doctor.lname}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: screenWidth * 0.05),
                                ),
                                Text(
                                  widget.doctor.specialization!,
                                  style:
                                      TextStyle(fontSize: screenWidth * 0.035),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
                  padding: EdgeInsets.all(screenWidth * 0.012),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          blurRadius: 20,
                          offset: const Offset(0, 10)),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: screenWidth * 0.44,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: selectedValue,
                          items: clinics.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Text(
                                  value,
                                  style:
                                      TextStyle(fontSize: screenWidth * 0.035),
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedValue = newValue!;
                              filterSessions();
                            });
                          },
                          dropdownColor: Colors.grey[200],
                          borderRadius: BorderRadius.circular(20.0),
                          underline: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.transparent),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.only(left: 15),
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Row(
                            children: <Widget>[
                              Text(
                                '${selectedDate.toLocal()}'.split(' ')[0],
                              ),
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
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.025),
                if (filteredSessions.isEmpty)
                  Container(
                    padding: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.1,
                        horizontal: screenWidth * 0.1),
                    child: const Text(
                      "No sessions for selected date or clinic",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ...filteredSessions
                    .map((session) => SessionTemplate(session: session))
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SessionTemplate extends StatelessWidget {
  const SessionTemplate({required this.session, super.key});

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

    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(
              left: screenWidth * 0.08,
              right: screenWidth * 0.08,
              bottom: screenHeight * 0.025),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(40),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.35),
                  blurRadius: 20,
                  offset: const Offset(0, 5)),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: screenHeight * 0.05,
                decoration: const BoxDecoration(
                  color: Color(0xFF2980B9),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40)),
                ),
                child: Center(
                  child: Text(
                    formatDate(session.date),
                    style: TextStyle(
                        color: Colors.white, fontSize: screenWidth * 0.04),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.025),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      session.clinic,
                      style: TextStyle(
                          fontSize: screenWidth * 0.034,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "${convertTime(session.timeFrom)} - ${convertTime(session.timeTo)}",
                      style: TextStyle(fontSize: screenWidth * 0.034),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Active Patients : ${session.activePatients}",
                      style: TextStyle(fontSize: screenWidth * 0.034),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Channeling Fee : ${session.docFee + session.clinicFee}",
                      style: TextStyle(fontSize: screenWidth * 0.034),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                        child: session.noOfPatients == session.activePatients
                            ? Text(
                                "The session is full",
                                style: TextStyle(
                                    fontSize: screenWidth * 0.035,
                                    color: Colors.grey),
                              )
                            : SizedBox(
                                width: double.infinity,
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              AppointmentConfirmation(
                                                session: session,
                                              )),
                                    );
                                  },
                                  style: TextButton.styleFrom(
                                    backgroundColor: const Color(0xFF2980B9),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                  ),
                                  child: Text(
                                    "Book now",
                                    style: TextStyle(
                                        fontSize: screenWidth * 0.034,
                                        color: Colors.white),
                                  ),
                                ),
                              ))
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.025)
            ],
          ),
        ),
      ],
    );
  }
}
