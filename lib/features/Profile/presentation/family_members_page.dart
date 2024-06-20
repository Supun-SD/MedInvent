import 'package:MedInvent/features/Profile/data/models/familyMember.dart';
import 'package:MedInvent/features/Profile/presentation/addFamilyMember.dart';
import 'package:MedInvent/providers/authProvider.dart';
import 'package:MedInvent/providers/familyMembersProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'FamilyMemberProfile.dart';

class FamilyMembers extends ConsumerStatefulWidget {
  const FamilyMembers({super.key});

  @override
  ConsumerState<FamilyMembers> createState() => _FamilyMembersState();
}

class _FamilyMembersState extends ConsumerState<FamilyMembers> {
  @override
  void initState() {
    super.initState();
    initialize();
  }

  void initialize() async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      String userID = ref.watch(userProvider)!.userId;
      ref.read(familyMembersProvider.notifier).getFamilyMembers(userID);
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    List<FamilyMember> familyMembers =
        ref.watch(familyMembersProvider).familyMembers;
    bool isLoading = ref.watch(familyMembersProvider).isLoading;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              icon: const Icon(Icons.person_add_alt_rounded),
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
            ),
          ),
        ],
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
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.18),
              child: Column(
                children: [
                  SizedBox(
                    height: screenHeight * 0.055,
                  ),
                  if (isLoading)
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: screenHeight * 0.1),
                      child: const SpinKitCircle(
                        size: 40,
                        color: Colors.blue,
                      ),
                    )
                  else
                    familyMembers.isEmpty
                        ? Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: screenWidth * 0.05,
                                vertical: screenHeight * 0.07),
                            child: Text(
                              "No family members added yet",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: screenHeight * 0.02,
                                  color: Colors.grey),
                            ),
                          )
                        : Column(children: [
                            ...familyMembers
                                .map((fm) => FamilyMemberCard(
                                      familyMember: fm,
                                      onDelete: () => ref
                                          .read(familyMembersProvider.notifier)
                                          .deleteFamilyMember(fm.dID!),
                                    ))
                                .toList()
                          ]),
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

class FamilyMemberCard extends StatelessWidget {
  final FamilyMember familyMember;
  final VoidCallback onDelete;

  const FamilyMemberCard({
    Key? key,
    required this.familyMember,
    required this.onDelete,
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(width: screenWidth * 0.05),
                  Image.asset(
                    "assets/images/pic.png",
                    height: screenWidth * 0.15,
                  ),
                  SizedBox(width: screenWidth * 0.05),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        familyMember.fname!,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: screenHeight * 0.02),
                      ),
                      Text(
                        familyMember.relationship!,
                        style: TextStyle(fontSize: screenHeight * 0.015),
                      ),
                    ],
                  ),
                ],
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: onDelete,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
