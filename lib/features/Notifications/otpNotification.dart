import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:MedInvent/features/Profile/services/dependent_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:MedInvent/features/login/data/models/user_model.dart';
import 'package:MedInvent/features/Profile/data/models/otp.dart';
import 'dart:convert';

class OTPNotification extends ConsumerStatefulWidget {
  const OTPNotification({super.key});

  @override
  ConsumerState<OTPNotification> createState() => _OTPNotificationState();
}

class _OTPNotificationState extends ConsumerState<OTPNotification> {
  late Future<List<OTP>> otpList;
  late User user;
  late OTP otp;

  @override
  void initState() {
    super.initState();
    otpList = Future.value([]);
    _initialize();
  }

  void _initialize() async {
    await _getNic();
    fetchOTPNotifications();
  }

  void fetchOTPNotifications() async {
    setState(() {
      otpList = getOTPObjectList();
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

  Future<List<OTP>> getOTPObjectList() async {
    try {
      //user.nic
      otp = OTP(0, "no",user.nic, "");
      BaseClient baseClient = BaseClient();
      var response =
          await baseClient.post('/Notification/get/All/OTP', otp.toRawJson());
      if (response != null) {
        print(response);
        return OTP.otpFromJson(response);
      } else {
        return [];
      }
    } catch (e) {
      print("Error: $e");
      return [];
    }
  }

  Future<void> _getNic() async {
    print("heloo");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString('user');
    //String? receiverToken = prefs.getString('FcmToken');
    if (userJson != null ) {
      Map<String, dynamic> userMap = jsonDecode(userJson);
      user = User.fromJson(userMap);
     // otp.receiverToken = receiverToken;
    }
  }

  Future<void> deleteReceiveOTP(String id) async {
    try {
      BaseClient baseClient = BaseClient();
      await baseClient.delete('/Notification/Receive/delete/$id');
      // Refresh the list after
      fetchOTPNotifications();
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
        title: const Text("OTP Messages"),
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
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.18),
              child: Column(
                children: [
                  SizedBox(
                    height: screenHeight * 0.055,
                  ),
                  FutureBuilder<List<OTP>>(
                    future: otpList,
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
                            "NO any OTP messages in your history",
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
                              otp: e,
                              onDelete: () => deleteReceiveOTP(e.OTP_id!),
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
  final OTP otp;
  final VoidCallback onDelete;

  const OtpCard({Key? key, required this.otp, required this.onDelete}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.only(bottom: screenHeight * 0.02),
      child: Container(
        width: double.infinity,
        height: screenHeight * 0.1,
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
              width: screenWidth * 0.05,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  otp.sendBy!,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: screenHeight * 0.02),
                ),
                Text(
                  '${otp.OTPNumber}',
                  style: TextStyle(fontSize: screenHeight * 0.023),
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
