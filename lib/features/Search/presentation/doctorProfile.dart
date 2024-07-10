import 'package:MedInvent/config/api.dart';
import 'package:MedInvent/features/Search/models/session.dart';
import 'package:MedInvent/features/Search/presentation/appointmentConfirmation.dart';
import 'package:MedInvent/features/Search/presentation/doctorSessions.dart';
import 'package:flutter/material.dart';
import 'package:MedInvent/features/Search/models/Doctor.dart';
import 'package:intl/intl.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DoctorProfile extends StatefulWidget {
  const DoctorProfile({required this.doctor, Key? key}) : super(key: key);

  final Doctor doctor;

  @override
  State<DoctorProfile> createState() => _DoctorProfileState();
}

class _DoctorProfileState extends State<DoctorProfile> {
  List<Session> todaySessions = [];
  List<Session> allSessions = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchSessions();
  }

  Future<void> fetchSessions() async {
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);

    String apiUrl =
        '${ApiConfig.baseUrl}/session/get/doctor/upcoming/${widget.doctor.id}';
    setState(() {
      isLoading = true;
    });
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);

        if (jsonResponse['data'] != null) {
          List<dynamic> sessions = jsonResponse['data'];

          for (var session in sessions) {
            Session newSession = Session.fromJson(session);
            if(!session['isCancelled']){
              allSessions.add(newSession);
            }
            bool isToday = ((session['date'] == formattedDate) &&
                (session['activePatients'] < session['noOfPatients']) && !session['isCancelled']);

            if (isToday) {
              todaySessions.add(newSession);
            }
          }
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Failed loading today's sessions"),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        isLoading = false;
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
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: screenHeight * 0.025),
        child: TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DoctorSessions(
                        doctor: widget.doctor,
                        sessions: allSessions,
                      )),
            );
          },
          style: TextButton.styleFrom(
            backgroundColor: const Color(0xFF186394),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.15, vertical: screenHeight * 0.01),
            child: const Text(
              "Book an appointment",
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: SingleChildScrollView(
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
                        height: screenHeight * 0.28,
                      ),
                      Positioned(
                        left: screenWidth * 0.08,
                        right: screenWidth * 0.08,
                        top: screenHeight * 0.065,
                        child: Container(
                          width: screenWidth * 0.8,
                          height: screenHeight * 0.2,
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
                                "Dr ${widget.doctor.fname} ${widget.doctor.mname} ${widget.doctor.lname}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: screenWidth * 0.055),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                widget.doctor.specialization!,
                                style: TextStyle(fontSize: screenWidth * 0.04),
                              ),
                              const SizedBox(
                                height: 20,
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
                              "assets/images/doctorDP.png",
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
                    height: screenHeight * 0.01,
                  ),
                  Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.4),
                          blurRadius: 20,
                        ),
                      ],
                      color: Colors.white,
                    ),
                    width: screenWidth,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.4),
                                blurRadius: 20,
                              ),
                            ],
                            color: const Color(0xFF2980B9),
                          ),
                          width: double.infinity,
                          child: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              "Available slots for today",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.05,
                              vertical: screenHeight * 0.025),
                          child: isLoading
                              ? const SpinKitCircle(
                                  size: 25,
                                  color: Colors.blue,
                                )
                              : todaySessions.isEmpty
                                  ? const Center(
                                      child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 25),
                                      child: Text("No session for today"),
                                    ))
                                  : Column(
                                      children: [
                                        ...todaySessions.map((session) =>
                                            SessionTemplate(session: session))
                                      ],
                                    ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.025,
                  ),
                  Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.4),
                          blurRadius: 20,
                        ),
                      ],
                      color: Colors.white,
                    ),
                    width: screenWidth,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.4),
                                blurRadius: 20,
                              ),
                            ],
                            color: const Color(0xFF2980B9),
                          ),
                          width: double.infinity,
                          child: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              "Special notes",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.08,
                              vertical: screenHeight * 0.04),
                          child: widget.doctor.note == null
                              ? const Text("No special notes for this doctor")
                              : Text(
                                  widget.doctor.note!,
                                  style: const TextStyle(fontSize: 15),
                                ),
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
    );
  }
}

class SessionTemplate extends StatelessWidget {
  const SessionTemplate({required this.session, super.key});
  final Session session;

  String convertTime(String time) {
    DateTime dateTime = DateTime.parse('1970-01-01 $time');
    String formattedTime = DateFormat('h:mm a').format(dateTime);

    return formattedTime;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AppointmentConfirmation(session: session)),
        )
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(15),
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xFFEDEDED),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  session.clinic,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold),
                ),
                Text(convertTime(session.timeFrom))
              ],
            ),
            Text(
              "${session.activePatients}/${session.noOfPatients}",
              style: const TextStyle(fontSize: 17),
            )
          ],
        ),
      ),
    );
  }
}

class HalfCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect =
        Rect.fromPoints(const Offset(0, 0), Offset(size.width, size.height));

    const gradient = LinearGradient(
      colors: [
        Color(0xFF474CA0),
        Color(0xFF468FA0),
      ],
    );

    final Rect gradientRect = Rect.fromPoints(rect.topLeft, rect.bottomRight);

    final paint = Paint()..shader = gradient.createShader(gradientRect);

    canvas.drawPath(
      getHalfCirclePath(rect),
      paint,
    );
  }

  Path getHalfCirclePath(Rect rect) {
    return Path()
      ..moveTo(rect.left, rect.bottom)
      ..arcToPoint(
        Offset(rect.right, rect.bottom),
        radius: Radius.circular(rect.width / 1.5),
        clockwise: false,
      )
      ..lineTo(rect.right, rect.top)
      ..lineTo(rect.left, rect.top)
      ..close();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
