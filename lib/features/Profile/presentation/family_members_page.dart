import 'package:MedInvent/features/Profile/presentation/Add_member_page.dart';
import 'package:MedInvent/components/input_field_edit.dart';
import 'package:MedInvent/components/otp_input.dart';
import 'package:flutter/material.dart';
import 'package:MedInvent/components/BottomNavBar.dart';
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

    List<Widget> familyMembers = [
      const FamilyMember(
          name: "Amali Siriwardana",
          relation: "Mother",
          profilePhoto: "assets/images/pic.png"),
      const FamilyMember(
          name: "John Doe",
          relation: "Son",
          profilePhoto: "assets/images/pic.png"),
      const FamilyMember(
          name: "Jessica Johns",
          relation: "Daughter",
          profilePhoto: "assets/images/pic.png"),
    ];

    return Scaffold(
      body: Stack(
        children: [
          Container(
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
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: screenHeight * 0.85,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(screenHeight * 0.06),
                  topRight: Radius.circular(screenHeight * 0.06),
                ),
                color: Colors.white,
              ),
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
                          : familyMembers,
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
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.05),
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
        ],
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

    return SizedBox(
      height: screenHeight * 0.4,
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

class FamilyMember extends StatelessWidget {
  final String name;
  final String relation;
  final String profilePhoto;
  final VoidCallback? onTapCallback;

  const FamilyMember({
    Key? key,
    required this.name,
    required this.relation,
    required this.profilePhoto,
    this.onTapCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const FamilyMemberProfile(),
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
                profilePhoto,
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
                    name,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: screenHeight * 0.02),
                  ),
                  Text(
                    relation,
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
