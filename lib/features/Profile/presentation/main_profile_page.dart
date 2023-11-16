import 'package:MedInvent/features/Profile/presentation/basic_info_page.dart';
import 'package:MedInvent/features/Profile/presentation/family_members_page.dart';
import 'package:MedInvent/features/Profile/presentation/security_info_page.dart';
import 'package:MedInvent/presentation/components/BottomNavBar.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {

    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.topRight,
              colors: [
                Color(0xFF474CA0),
                Color(0xFF468FA0),
              ],
            ),
          ),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(top: screenHeight * 0.15),
                height: screenHeight,
                width: screenWidth,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(horizontal: screenWidth*0.08, vertical: screenHeight *0.05),
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
                          const MyProfiletab(
                            iconprofile: Icons.facebook,
                            buttonTextMain1: 'Dhanushka',
                            buttonTextMain2: 'danu@test.com',
                            iconDiamond: Icons.diamond,
                            number: '335',
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
                            // Your content for the first container
                          ),
                          Mybutton(
                            iconData1: Icons.verified_user_outlined,
                            buttonText1: 'Security Information',
                            buttonText2: 'Email Address,Telephone,Password',
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
                            iconData1: Icons.notifications_active_outlined,
                            buttonText1: 'Notifications',
                            buttonText2: 'Medicine,Notification settings',
                            iconData2: Icons.navigate_next,
                            onTap: () {},
                          ),
                          Container(
                            color: Colors.black12,
                            width: 290.0,
                            height: 1,
                          ),
                          Mybutton(
                            iconData1: Icons.g_translate_outlined,
                            buttonText1: 'Language',
                            buttonText2: 'Change app language',
                            iconData2: Icons.navigate_next,
                            onTap: () {},
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
                                    builder: (context) => const Familymembers()),
                              );
                            },
                          ),
                          SizedBox(height: screenHeight*0.03,)
                        ],
                      ),
                    ),
                    Container(
                      height: 70,
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
                        iconData1: Icons.help_outline,
                        buttonText1: 'Family Members',
                        buttonText2: 'Edit,',
                        iconData2: Icons.navigate_next,
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
      bottomNavigationBar: const BottomNavBar(),
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
                child: Container(
                  height: 62,
                  margin: const EdgeInsets.only(right: 15, top: 5),
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

class MyProfiletab extends StatelessWidget {
  const MyProfiletab({
    super.key,
    required this.iconprofile,
    required this.buttonTextMain1,
    required this.buttonTextMain2,
    required this.iconDiamond,
    required this.number,
  });

  final IconData iconprofile;
  final String buttonTextMain1;
  final String buttonTextMain2;
  final IconData iconDiamond;
  final String number;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        height: 75,
        width: 310,
        margin: const EdgeInsets.only(top: 30.0, left: 3.0, right: 0.0),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ClipOval(
                child: Image.asset(
                  'assets/images/pic.png',
                  width: 54.0,
                  height: 54.0,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              height: 46,
              margin: const EdgeInsets.only(left: 15.0, right: 40.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      buttonTextMain1,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      buttonTextMain2,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black45,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ]),
            ),
            Icon(
              iconDiamond,
              color: Colors.red,
            ),
            Text(
              number,
            ),
          ],
        ),
      ),
    );
  }
}
