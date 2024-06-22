import 'package:MedInvent/components/sideNavBar.dart';
import 'package:MedInvent/features/Profile/presentation/basic_info_page.dart';
import 'package:MedInvent/features/Profile/presentation/family_members_page.dart';
import 'package:MedInvent/features/Profile/presentation/security_info_page.dart';
import 'package:MedInvent/providers/authProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:MedInvent/features/Profile/presentation/NotificationTopicCollection.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      drawer: const SideNavBar(),
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
        title: const Text("Profile"),
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
                )),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.08,
                      vertical: screenHeight * 0.05),
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
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.05,
                            vertical: screenHeight * 0.02),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/images/pic.png',
                              height: screenHeight * 0.07,
                            ),
                            const SizedBox(
                              width: 25,
                            ),
                            Text(
                              '${ref.watch(userProvider)!.fname} ${ref.watch(userProvider)!.lname}',
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                      Container(
                        color: Colors.black12,
                        width: 290.0,
                        height: 1,
                      ),
                      Mybutton(
                        iconData1: Icons.perm_identity,
                        buttonText1: 'Basic Information',
                        buttonText2: 'Name,NIC,Gender,DOB..',
                        iconData2: Icons.navigate_next,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const BasicInfo()),
                          );
                        },
                      ),
                      Container(
                        color: Colors.black12,
                        width: 290.0,
                        height: 1,
                      ),
                      Mybutton(
                        iconData1: Icons.verified_user_outlined,
                        buttonText1: 'Security Information',
                        buttonText2: 'Email,Mobile,Password',
                        iconData2: Icons.navigate_next,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SecurityInfo()),
                          );
                        },
                      ),
                      Container(
                        color: Colors.black12,
                        width: 290.0,
                        height: 1,
                      ),
                      Mybutton(
                        iconData1: Icons.diversity_1_outlined,
                        buttonText1: 'Family Members',
                        buttonText2: 'Edit,Add Profiles',
                        iconData2: Icons.navigate_next,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const FamilyMembers()),
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
                Container(
                  height: 80,
                  width: 358,
                  alignment: Alignment.center,
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
                        blurRadius: 40.0,
                      ),
                    ],
                  ),
                  child: Mybutton(
                    iconData1: Icons.notifications_active_outlined,
                    buttonText1: 'Notifications',
                    buttonText2: 'tap to view all Notifications',
                    iconData2: Icons.navigate_next,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const NotificationCategory()),
                      );
                    },
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
                child: SizedBox(
                  width: 200,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
