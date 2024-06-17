import 'package:MedInvent/features/Search/presentation/doctorAppointments.dart';
import 'package:flutter/material.dart';
import 'package:MedInvent/features/Search/models/Doctor.dart';

class DoctorProfile extends StatelessWidget {
  const DoctorProfile({required this.doctor, Key? key}) : super(key: key);

  final Doctor doctor;

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
                  builder: (context) => DoctorAppointments(doctor: doctor)),
            );
          },
          style: TextButton.styleFrom(
            backgroundColor: const Color(0xFF4749A0),
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
                        height: screenHeight * 0.33,
                      ),
                      Positioned(
                        left: screenWidth * 0.08,
                        right: screenWidth * 0.08,
                        top: screenHeight * 0.065,
                        child: Container(
                          width: screenWidth * 0.8,
                          height: screenHeight * 0.25,
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
                                "Dr ${doctor.fname} ${doctor.mname} ${doctor.lname}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: screenWidth * 0.055),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                doctor.specialization,
                                style: TextStyle(fontSize: screenWidth * 0.04),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 45.0,
                                    height: 45.0,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xFF2980B9),
                                    ),
                                    child: IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                          Icons.mail_outline_rounded,
                                          color: Colors.white,
                                          size: 20),
                                      padding: const EdgeInsets.all(8.0),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    width: 45.0,
                                    height: 45.0,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xFF2980B9),
                                    ),
                                    child: IconButton(
                                      onPressed: () {},
                                      icon: const Icon(Icons.link,
                                          color: Colors.white, size: 20),
                                      padding: const EdgeInsets.all(8.0),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    width: 45.0,
                                    height: 45.0,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xFF2980B9),
                                    ),
                                    child: IconButton(
                                      onPressed: () {},
                                      icon: const Icon(Icons.message_outlined,
                                          color: Colors.white, size: 20),
                                      padding: const EdgeInsets.all(8.0),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    width: 45.0,
                                    height: 45.0,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xFF2980B9),
                                    ),
                                    child: IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                          Icons.location_on_outlined,
                                          color: Colors.white,
                                          size: 20),
                                      padding: const EdgeInsets.all(8.0),
                                    ),
                                  ),
                                ],
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
                          child: SessionTemplate(),
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
                              vertical: screenHeight * 0.025),
                          child: Text(
                            doctor.note,
                            style: TextStyle(fontSize: 15),
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
  const SessionTemplate({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
              Text("Health care clinic", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
              Text("5:30 PM")
            ],
          ),
          Text("12/20", style: TextStyle(fontSize: 17),)
        ],
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
