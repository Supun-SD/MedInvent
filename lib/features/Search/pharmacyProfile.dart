import 'package:MedInvent/features/Search/doctorProfile.dart';
import 'package:MedInvent/features/Search/models/pharmacy.dart';
import 'package:flutter/material.dart';

class PharmacyProfile extends StatelessWidget {
  const PharmacyProfile({required this.pharmacy, super.key});
  final Pharmacy pharmacy;
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Scaffold(
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
        body: DefaultTabController(
          length: 2,
          child: SingleChildScrollView(
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
                              height: screenHeight * 0.24,
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
                                    pharmacy.name,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: screenWidth * 0.055),
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
                                          icon: const Icon(
                                              Icons.message_outlined,
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
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Image.asset(
                                "assets/images/pic.png",
                                height: screenHeight * 0.12,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: screenHeight * 0.02,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.08),
                        width: double.infinity,
                        child: const TabBar(
                          tabs: [
                            Tab(
                              text: 'Overview',
                            ),
                            Tab(text: 'Reviews'),
                          ],
                          labelColor: Colors.blue,
                          unselectedLabelColor: Colors.black,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.09),
                        height: screenHeight * 0.5,
                        width: double.infinity,
                        child: TabBarView(
                          children: [
                            Details(
                              pharmacy: pharmacy,
                            ),
                            const Reviews()
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
      ),
    );
  }
}

class Details extends StatelessWidget {
  const Details({required this.pharmacy, super.key});
  final Pharmacy pharmacy;
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        SizedBox(
          height: screenHeight * 0.05,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
                width: screenWidth * 0.3,
                child: Text(
                  "Address",
                  style: TextStyle(fontSize: screenWidth * 0.035),
                )),
            Expanded(
                child: Text(
              pharmacy.address,
              style: TextStyle(
                  fontSize: screenWidth * 0.035, fontWeight: FontWeight.bold),
            ))
          ],
        ),
        SizedBox(
          height: screenHeight * 0.015,
        ),
        Row(
          children: [
            SizedBox(
                width: screenWidth * 0.3,
                child: Text(
                  "Open hours",
                  style: TextStyle(fontSize: screenWidth * 0.035),
                )),
            Text(
              "${pharmacy.openTime} to ${pharmacy.closeTime} ",
              style: TextStyle(
                  fontSize: screenWidth * 0.035, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(
          height: screenHeight * 0.015,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
                width: screenWidth * 0.3,
                child: Text(
                  "Days",
                  style: TextStyle(fontSize: screenWidth * 0.035),
                )),
            Expanded(
              child: Text(
                pharmacy.datesList.join(", "),
                style: TextStyle(
                    fontSize: screenWidth * 0.035, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
        SizedBox(
          height: screenHeight * 0.015,
        ),
        Row(
          children: [
            SizedBox(
                width: screenWidth * 0.3,
                child: Text(
                  "Contact Number",
                  style: TextStyle(fontSize: screenWidth * 0.035),
                )),
            Text(
              pharmacy.contact,
              style: TextStyle(
                  fontSize: screenWidth * 0.035, fontWeight: FontWeight.bold),
            )
          ],
        ),
        SizedBox(
          height: screenHeight * 0.05,
        ),
        TextButton(
          onPressed: () {},
          style: ButtonStyle(
            side: MaterialStateProperty.all(const BorderSide(color: Color(0xFF2980B9), width: 1.0)),
            foregroundColor: MaterialStateProperty.all(const Color(0xFF2980B9)),
            padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: screenWidth * 0.1)),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
                side: const BorderSide(color: Color(0xFF2980B9), width: 1.0),
              ),
            ),
          ),
          child: const Text("Provide feedback"),
        )
      ],
    );
  }
}

class Reviews extends StatelessWidget {
  const Reviews({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Reviews"),
    );
  }
}
