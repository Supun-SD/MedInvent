import 'package:MedInvent/components/sideNavBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:MedInvent/features/Notifications/otpNotification.dart';
import 'package:MedInvent/features/Notifications/cancelSessionNotification.dart';
import 'package:MedInvent/features/Notifications/doctorArriveNotification.dart';


class NotificationCategory extends ConsumerWidget {
  const NotificationCategory({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
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
        title: const Text("Notification Categories"),
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
            margin: EdgeInsets.only(top: screenHeight * 0.04),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50.0),
                  topRight: Radius.circular(50.0),
                )),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.08,
                      vertical: screenHeight * 0.08),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 100.0,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        color: Colors.black12,
                        width: 290.0,
                        height: 1,
                      ),
                      Mybutton(
                        iconData1: Icons.notifications_active_outlined,
                        buttonText1: 'Cancel Session Notifications',
                        buttonText2: 'Tap to view All',
                        iconData2: Icons.navigate_next,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const CancelNotification()),
                          );
                        },
                      ),
                      Container(
                        color: Colors.black12,
                        width: 290.0,
                        height: 1,
                      ),
                      Mybutton(
                        iconData1: Icons.notifications_active_outlined,
                        buttonText1: 'Doctor Arrive Notifications',
                        buttonText2: 'Tap to view',
                        iconData2: Icons.navigate_next,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ArriveNotification()),
                          );
                        },
                      ),
                      Container(
                        color: Colors.black12,
                        width: 290.0,
                        height: 1,
                      ),
                      Mybutton(
                        iconData1: Icons.notifications_active_outlined,
                        buttonText1: 'Link Device Notification',
                        buttonText2: 'Tap to view',
                        iconData2: Icons.navigate_next,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const OTPNotification()),
                          );
                        },
                      ),
                      Container(
                        color: Colors.black12,
                        width: 290.0,
                        height: 1,
                      ),
                      SizedBox(
                        height: screenHeight * 0.05,
                      )
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

class Mybutton extends StatelessWidget {
  const Mybutton({
    super.key,
    required this.iconData1,
    required this.buttonText1,
    required this.buttonText2,
    required this.iconData2,
    required this.onTap,
  });

  final IconData iconData1;
  final String buttonText1;
  final String buttonText2;
  final IconData iconData2;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: 62,
        width: 288,
        child: Row(
          children: [
            Icon(
              iconData1,
              color: Colors.blue,
            ),
            Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  width: 200,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: screenHeight * 0.014,
                        ),
                        Text(
                          buttonText1,
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          buttonText2,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black45,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ]),
                )),
            Icon(
              iconData2,
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}
