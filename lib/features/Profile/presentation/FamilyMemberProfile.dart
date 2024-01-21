import 'package:MedInvent/features/Profile/data/models/familyMember.dart';
import 'package:flutter/material.dart';

class FamilyMemberProfile extends StatefulWidget {
  final FamilyMember familyMember;
  const FamilyMemberProfile({required this.familyMember,super.key});

  @override
  State<FamilyMemberProfile> createState() => FamilyMemberProfileState();
}

class FamilyMemberProfileState extends State<FamilyMemberProfile> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    String profilePic = "assets/images/pic.png";
    int loyalityPoints = 335;

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: screenHeight * 0.25,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(screenHeight * 0.15),
                  bottomRight: Radius.circular(screenHeight * 0.15),
                ),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.topRight,
                  colors: [
                    Color(0xFF474CA0),
                    Color(0xFF468FA0),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: screenHeight * 0.185,
            right: 0,
            left: 0,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                  child: Container(
                    height: screenHeight * 0.18,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(screenWidth * 0.07),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 20,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: screenHeight * 0.075,
                        ),
                        Text(
                          widget.familyMember.name,
                          style: TextStyle(
                              fontSize: screenHeight * 0.02,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: screenHeight * 0.005,
                        ),
                        Text(
                          widget.familyMember.relationship,
                          style: TextStyle(fontSize: screenHeight * 0.015),
                        ),
                        SizedBox(
                          height: screenHeight * 0.008,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.diamond_rounded,
                              size: screenHeight * 0.02,
                              color: Colors.red,
                            ),
                            SizedBox(
                              width: screenWidth * 0.01,
                            ),
                            Text(
                              loyalityPoints.toString(),
                              style: TextStyle(fontSize: screenWidth * 0.035),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.025,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                  child: Container(
                    height: screenHeight * 0.2,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(screenWidth * 0.07),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 20,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(top: screenHeight * 0.02),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Column(
                            children: [
                              TitleBox(title: "NIC"),
                              TitleBox(title: "Gender"),
                              TitleBox(title: "Date of Birth"),
                              TitleBox(title: "Height"),
                              TitleBox(title: "Weight"),
                            ],
                          ),
                          Column(
                            children: [
                              DataBox(data: widget.familyMember.NIC),
                              DataBox(data: widget.familyMember.gender),
                              DataBox(data: widget.familyMember.dob),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.025,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                  child: Container(
                    height: screenHeight * 0.2,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(screenWidth * 0.07),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 20,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        "No prescriptions assigned",
                        style: TextStyle(
                            fontSize: screenHeight * 0.015, color: Colors.grey),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: screenHeight * 0.13,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 4.0,
                ),
              ),
              child: Image.asset(
                profilePic,
                height: screenHeight * 0.11,
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              title: const Text("Family Profiles"),
              elevation: 0,
              backgroundColor: Colors.transparent,
              toolbarHeight: screenHeight * 0.1,
            ),
          ),
        ],
      ),
    );
  }
}

class TitleBox extends StatelessWidget {
  final String title;

  const TitleBox({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      width: screenWidth * 0.3,
      height: screenHeight * 0.032,
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: screenHeight * 0.016, color: Colors.black45),
          ),
        ],
      ),
    );
  }
}

class DataBox extends StatelessWidget {
  final String data;

  const DataBox({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      width: screenWidth * 0.35,
      height: screenHeight * 0.032,
      child: Row(
        children: [
          Text(
            data,
            style:
                TextStyle(fontSize: screenHeight * 0.016, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
