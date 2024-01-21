import 'package:MedInvent/features/Profile/data/datasources/familyMembers.dart';
import 'package:MedInvent/features/Profile/data/models/familyMember.dart';
import 'package:MedInvent/features/Profile/presentation/Add_member_page.dart';
import 'package:MedInvent/components/input_field_edit.dart';
import 'package:MedInvent/components/otp_input.dart';
import 'package:flutter/material.dart';
import 'FamilyMemberProfile.dart';

class FamilyMembers extends StatefulWidget {
  const FamilyMembers({super.key});

  @override
  State<FamilyMembers> createState() => _FamilyMembersState();
}

class _FamilyMembersState extends State<FamilyMembers> {
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
        title: const Text("Family Members"),
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
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
              child: Column(
                children: [
                  SizedBox(
                    height: screenHeight * 0.05,
                  ),
                  Column(
                    children: familyMembers.isEmpty
                        ? [
                            Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: screenWidth * 0.05,
                                    vertical: screenHeight * 0.07),
                                child: Text(
                                  "You don't have any family member added",
                                  style: TextStyle(
                                      fontSize: screenHeight * 0.02,
                                      color: Colors.grey),
                                )),
                          ]
                        : familyMembers
                            .map((e) => FamilyMemberCard(familyMember: e))
                            .toList(),
                  ),
                  SizedBox(
                    height: screenHeight * 0.04,
                  ),
                  TextButton(
                    onPressed: () {
                      showModalBottomSheet(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                              top: Radius.circular(screenHeight * 0.05)),
                        ),
                        context: context,
                        builder: (BuildContext context) {
                          return const AddNewMember();
                        },
                      );
                    },
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(screenHeight * 0.05),
                        side: const BorderSide(color: Color(0xFF2980B9)),
                      ),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                      child: Text(
                        "Add Member",
                        style: TextStyle(
                            color: const Color(0xFF2980B9),
                            fontSize: screenHeight * 0.015),
                      ),
                    ),
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

class AddNewMember extends StatefulWidget {
  const AddNewMember({super.key});

  @override
  State<AddNewMember> createState() => _AddNewMemberState();
}

class _AddNewMemberState extends State<AddNewMember> {
  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    return SizedBox(
      height: screenHeight * 0.4 + keyboardSpace,
      child: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            Selection(
              pageController: _pageController,
            ),
            LinkProfile(
              pageController: _pageController,
            ),
            OtpVerify(pageController: _pageController),
          ]),
    );
  }
}

class Selection extends StatelessWidget {
  final PageController pageController;

  const Selection({super.key, required this.pageController});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      child: Column(
        children: [
          SizedBox(
            height: screenHeight * 0.04,
          ),
          Text(
            "Add a family member",
            style: TextStyle(
                fontSize: screenHeight * 0.02, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: screenHeight * 0.05,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Link Profile",
                    style: TextStyle(fontSize: screenHeight * 0.018),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                        borderRadius:
                            BorderRadius.circular(screenHeight * 0.015),
                      ),
                      child: IconButton(
                        onPressed: () {
                          pageController.animateToPage(1,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut);
                        },
                        icon: const Icon(
                          Icons.link_rounded,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    "Link an existing profile",
                    style: TextStyle(fontSize: screenHeight * 0.013),
                  )
                ],
              ),
              SizedBox(
                width: screenWidth * 0.1,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "New profile",
                    style: TextStyle(fontSize: screenHeight * 0.018),
                  ),
                  Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                          borderRadius:
                              BorderRadius.circular(screenHeight * 0.015),
                        ),
                        child: IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AddMember(),
                              ),
                            );
                          },
                          icon: const Icon(
                            Icons.person_add_alt_1,
                          ),
                        ),
                      )),
                  Text(
                    "Create a local account",
                    style: TextStyle(fontSize: screenHeight * 0.013),
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}

class LinkProfile extends StatelessWidget {
  final PageController pageController;

  const LinkProfile({super.key, required this.pageController});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Column(
      children: [
        SizedBox(
          height: screenHeight * 0.03,
        ),
        Text(
          "Link Profile",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: screenHeight * 0.02),
        ),
        Inputbutton(
          topic: 'Relationship',
          tvalue: screenHeight * 0.02,
          wiht: screenWidth * 0.75,
        ),
        Inputbutton(
          topic: 'Mobile number',
          tvalue: screenHeight * 0.02,
          wiht: screenWidth * 0.75,
        ),
        Inputbutton(
          topic: 'NIC',
          tvalue: screenHeight * 0.02,
          wiht: screenWidth * 0.75,
        ),
        SizedBox(
          height: screenHeight * 0.02,
        ),
        TextButton(
          onPressed: () {
            pageController.animateToPage(2,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut);
          },
          style: TextButton.styleFrom(
            backgroundColor: const Color(0xFF2980B9),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(screenHeight * 0.05),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
            child: Text(
              "Next",
              style: TextStyle(
                color: Colors.white,
                fontSize: screenHeight * 0.018,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class OtpVerify extends StatelessWidget {
  final PageController pageController;
  const OtpVerify({super.key, required this.pageController});
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: screenHeight * 0.04,
        ),
        Text(
          "Grant access",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: screenHeight * 0.02),
        ),
        SizedBox(
          height: screenHeight * 0.04,
        ),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.15),
            child: Text(
              "Enter the confirmation code sent to your relative's mobile number",
              style: TextStyle(fontSize: screenHeight * 0.015),
              textAlign: TextAlign.center,
            )),
        SizedBox(
          height: screenHeight * 0.03,
        ),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.2),
            child: const OTPInput()),
        SizedBox(
          height: screenHeight * 0.05,
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: TextButton.styleFrom(
            backgroundColor: const Color(0xFF2980B9),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(screenHeight * 0.05),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
            child: Text(
              "Add",
              style: TextStyle(
                color: Colors.white,
                fontSize: screenHeight * 0.018,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class FamilyMemberCard extends StatelessWidget {
  final FamilyMember familyMember;

  const FamilyMemberCard({Key? key, required this.familyMember})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FamilyMemberProfile(
              familyMember: familyMember,
            ),
          ),
        );
      },
      child: Padding(
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
                    familyMember.name,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: screenHeight * 0.02),
                  ),
                  Text(
                    familyMember.relationship,
                    style: TextStyle(fontSize: screenHeight * 0.015),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
