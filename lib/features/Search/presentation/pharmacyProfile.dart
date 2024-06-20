import 'package:MedInvent/features/Search/presentation/doctorProfile.dart';
import 'package:MedInvent/features/Search/models/Pharmacy.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../providers/nearbyPharmaciesAndDoctorsProvider.dart';

class PharmacyProfile extends StatelessWidget {
  const PharmacyProfile({required this.pharmacy, super.key});
  final Pharmacy pharmacy;

  void openDialer() async {
    final Uri dialNumber = Uri(
      scheme: 'tel',
      path: pharmacy.contactNo,
    );
    try {
      if (await canLaunchUrl(dialNumber)) {
        await launchUrl(dialNumber);
      } else {
        throw 'Could not launch $dialNumber';
      }
    } catch (e) {
      _showError("Error");
    }
  }

  void openGmail() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: pharmacy.email,
    );

    if (pharmacy.email == null) {
      _showError("No email for this pharmacy");
      return;
    }

    try {
      if (await canLaunchUrl(emailLaunchUri)) {
        await launchUrl(emailLaunchUri);
      } else {
        throw 'Could not launch $emailLaunchUri';
      }
    } catch (e) {
      _showError("Error");
    }
  }

  void openMessageApp() async {
    String phoneNumber = pharmacy.contactNo;
    final Uri smsUri = Uri(
      scheme: 'sms',
      path: phoneNumber,
    );

    try {
      if (await canLaunchUrl(smsUri)) {
        await launchUrl(smsUri);
      } else {
        throw 'Could not launch $smsUri';
      }
    } catch (e) {
      _showError("Error");
    }
  }

  void openGoogleMaps() async {
    final Uri googleMapsUri = Uri(
      scheme: 'https',
      host: 'www.google.com',
      path: '/maps',
      queryParameters: {
        'q': '${pharmacy.lat},${pharmacy.long}(${pharmacy.name})',
        'z': '15',
      },
    );
    try {
      if (await canLaunchUrl(googleMapsUri)) {
        await launchUrl(googleMapsUri);
      } else {
        throw 'Could not launch $googleMapsUri';
      }
    } catch (e) {
      _showError("Error");
    }
  }

  void _showError(String text) {
    scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(text),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 2),
      ),
    );
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
                                  pharmacy.name,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: screenWidth * 0.055),
                                ),
                                SizedBox(
                                  height: screenHeight * 0.025,
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
                                        onPressed: openDialer,
                                        icon: const Icon(Icons.call,
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
                                        onPressed: openGmail,
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
                                        onPressed: openMessageApp,
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
                                        onPressed: openGoogleMaps,
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
                                "assets/images/pharmacy.png",
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
                            text: 'Overview',
                          ),
                          Tab(text: 'Reviews'),
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
                          Details(
                            pharmacy: pharmacy,
                          ),
                          Reviews(
                            pharmacy: pharmacy,
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

class Details extends StatelessWidget {
  const Details({required this.pharmacy, super.key});
  final Pharmacy pharmacy;

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
              '${pharmacy.addressLineOne}, ${pharmacy.addressLineTwo}, ${pharmacy.city}, ${pharmacy.city}',
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
              "${convertTime(pharmacy.openHoursFrom)} to ${convertTime(pharmacy.openHoursTo)} ",
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
                pharmacy.openDays.join(", "),
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
              pharmacy.contactNo,
              style: TextStyle(
                  fontSize: screenWidth * 0.035, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ],
    );
  }
}

class Reviews extends StatelessWidget {
  const Reviews({required this.pharmacy, super.key});
  final Pharmacy pharmacy;
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: screenHeight * 0.05,
          ),
          // ...pharmacy.reviews.map((e) => ReviewTemplate(review: e)),
          SizedBox(
            height: screenHeight * 0.03,
          ),
          TextButton(
            onPressed: () {},
            style: ButtonStyle(
              side: MaterialStateProperty.all(
                  const BorderSide(color: Color(0xFF2980B9), width: 1.0)),
              foregroundColor:
                  MaterialStateProperty.all(const Color(0xFF2980B9)),
              padding: MaterialStateProperty.all(
                  EdgeInsets.symmetric(horizontal: screenWidth * 0.1)),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  side: const BorderSide(color: Color(0xFF2980B9), width: 1.0),
                ),
              ),
            ),
            child: const Text("Write a review"),
          ),
          SizedBox(
            height: screenHeight * 0.06,
          ),
        ],
      ),
    );
  }
}

// class ReviewTemplate extends StatelessWidget {
//   const ReviewTemplate({required this.review, super.key});
//   final Review review;
//   @override
//   Widget build(BuildContext context) {
//     final double screenWidth = MediaQuery.of(context).size.width;
//     final double screenHeight = MediaQuery.of(context).size.height;
//     return Column(
//       children: [
//         Row(
//           children: [
//             SizedBox(
//               width: screenWidth * 0.05,
//             ),
//             Image.asset(
//               "assets/images/pic.png",
//               width: screenWidth * 0.15,
//             ),
//             SizedBox(
//               width: screenWidth * 0.04,
//             ),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     review.name,
//                     style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: screenWidth * 0.04),
//                   ),
//                   const SizedBox(
//                     height: 5,
//                   ),
//                   Row(
//                     children: [
//                       for (int i = 0; i < review.stars; i++)
//                         const Icon(
//                           Icons.star,
//                           color: Color(0xFFFFBF00),
//                           size: 15,
//                         ),
//                     ],
//                   ),
//                   const SizedBox(
//                     height: 5,
//                   ),
//                   Text(review.review),
//                 ],
//               ),
//             )
//           ],
//         ),
//         Divider(
//           height: screenHeight * 0.04,
//           color: Colors.grey,
//           thickness: 0.7,
//         ),
//       ],
//     );
//   }
// }
