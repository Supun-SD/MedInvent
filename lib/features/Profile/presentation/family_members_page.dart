import 'package:MedInvent/features/Profile/presentation/Add_member_page.dart';
import 'package:flutter/material.dart';
import 'package:MedInvent/presentation/components/BottomNavBar.dart';
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
      FamilyMember(
          name: "Amali Siriwardana",
          relation: "Mother",
          profilePhoto: "assets/images/pic.png"),
      FamilyMember(
          name: "John Doe",
          relation: "Son",
          profilePhoto: "assets/images/pic.png"),
      FamilyMember(
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
                    AddmemberButton(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AddMember()),
                        );
                      },
                      save: 'Add Member',
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: BottomNavBar(),
          ),
        ],
      ),
    );
  }
}

class FamilyMember extends StatelessWidget {
  final String name;
  final String relation;
  final String profilePhoto;
  final VoidCallback? onTapCallback;

  FamilyMember({
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

class AddmemberButton extends StatelessWidget {
  const AddmemberButton({
    super.key,
    required this.onTap,
    required this.save,
  });
  final String save;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12.0),
        width: 135,
        alignment: Alignment.center,
        margin: const EdgeInsets.only(top: 50.0),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          ),
          color: Color(0xFF2980B9),
        ),
        child: Text(
          save,
          style: const TextStyle(
            fontSize: 15,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
