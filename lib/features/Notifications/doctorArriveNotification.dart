import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:MedInvent/features/Profile/services/dependent_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:MedInvent/features/login/data/models/user_model.dart';
import 'package:MedInvent/features/Notifications/models/doctorArrive.dart';
import 'dart:convert';

class ArriveNotification extends ConsumerStatefulWidget {
  const ArriveNotification({super.key});

  @override
  ConsumerState<ArriveNotification> createState() => _ArriveNotificationState();
}

class _ArriveNotificationState extends ConsumerState<ArriveNotification> {
  late Future<List<DoctorArrival>> arrivelList;
  late User user;
  late DoctorArrival arriveReference;

  @override
  void initState() {
    super.initState();
    arrivelList = Future.value([]);
    _initialize();
  }

  void _initialize() async {
    await _getUserID();
    fetchArriveNotifications();
  }

  void fetchArriveNotifications() async {
    setState(() {
      arrivelList = getArriveObjectList();
    });

    // Print the OTP list to the console
    //printOtpList();
  }

  // Future<void> printOtpList() async {
  //   try {
  //     List<OTP> otps = await otpList;
  //     for (OTP otp in otps) {
  //       print(otp.OTPNumber);
  //       print(otp.sendBy);
  //       print(otp.OTP_id);
  //     }
  //   } catch (e) {
  //     print("Error printing OTP list: $e");
  //   }
  // }

  Future<List<DoctorArrival>> getArriveObjectList() async {
    try {
      BaseClient baseClient = BaseClient();
      var response = await baseClient.get('/Session/get/All/arrive/messages/${user.userId}');
      if (response != null) {
        print(response);
        return DoctorArrival.otpFromJson(response);
      } else {
        return [];
      }
    } catch (e) {
      print("Error: $e");
      return [];
    }
  }

  Future<void> _getUserID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString('user');
    if (userJson != null ) {
      Map<String, dynamic> userMap = jsonDecode(userJson);
      user = User.fromJson(userMap);
    }
  }

  Future<void> deleteArriveMessage(String id) async {
    try {
      BaseClient baseClient = BaseClient();
      await baseClient.delete('/Session/delete/arrive/message/$id');
      // Refresh the list after
      fetchArriveNotifications();
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
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
        title: const Text("Doctor Arrived Messages"),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF474CA0),
              Color(0xFF468FA0),
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top: screenHeight * 0.025),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50.0),
                topRight: Radius.circular(50.0),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: Column(
                children: [
                  SizedBox(
                    height: screenHeight * 0.055,
                  ),
                  FutureBuilder<List<DoctorArrival>>(
                    future: arrivelList,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text("Error: ${snapshot.error}");
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.05,
                              vertical: screenHeight * 0.07),
                          child: Text(
                            "NO any  messages in your history",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: screenHeight * 0.02,
                                color: Colors.grey),
                          ),
                        );
                      } else {
                        return Column(
                          children: snapshot.data!
                              .map((e) => OtpCard(
                            arriveRef: e,
                            onDelete: () => deleteArriveMessage(e.arrive_id!),
                          ))
                              .toList(),
                        );
                      }
                    },
                  ),
                  SizedBox(
                    height: screenHeight * 0.04,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class OtpCard extends StatelessWidget {
  final DoctorArrival arriveRef;
  final VoidCallback onDelete;

  const OtpCard({Key? key, required this.arriveRef,required this.onDelete}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.only(bottom: screenHeight * 0.02),
      child: Container(
        width: double.infinity,
        height: screenHeight * 0.2,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(screenWidth * 0.07),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 20,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: screenWidth * 0.05,
            ),
            Image.asset(
              "assets/images/pic.png",
              height: screenWidth * 0.15,
            ),
            SizedBox(
              width: screenWidth * 0.04,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Doctor Arrived",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: screenHeight * 0.02,
                      color: Colors.blue[900]
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                Text(
                  arriveRef.clinicName!,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: screenHeight * 0.02),
                ),
                SizedBox(
                  height: screenHeight * 0.01,
                ),
                Text(
                  arriveRef.doctorFullName!,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: screenHeight * 0.02),
                ),
                SizedBox(
                  height: screenHeight * 0.01,
                ),
                Text(
                  '${arriveRef.date}',
                  style: TextStyle(
                      fontSize: screenHeight * 0.02,
                      fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.01,
                ),
                Text(
                  'Visit your doctor !',
                  style: TextStyle(
                      fontSize: screenHeight * 0.02,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.01,
                )
              ],
            ),
            SizedBox(
              width: screenWidth * 0.05,
            ),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.blue),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}
