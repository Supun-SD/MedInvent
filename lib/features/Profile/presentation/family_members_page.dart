import 'package:MedInvent/features/Profile/presentation/Add_member_page.dart';
import 'package:flutter/material.dart';
import 'package:MedInvent/presentation/components/BottomNavBar.dart';
import 'package:MedInvent/presentation/components/MemberSetDisplay.dart';

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
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                    child: SizedBox(
                      height: screenHeight * 0.5,
                      child: ListView.builder(
                          itemCount: 3,
                          itemBuilder: (context, index) {
                            return const MemberDisplay(
                                iconprofile: Icons.man,
                                buttonTextMain1: 'Amali Perera ',
                                buttonTextMain2: 'Mother',
                                iconDiamond: Icons.diamond,
                                number: '335');
                          }),
                    ),
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
        margin: const EdgeInsets.only(top: 70.0),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
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

