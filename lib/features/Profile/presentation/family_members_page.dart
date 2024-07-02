import 'package:MedInvent/features/Profile/models/familyMember.dart';
import 'package:MedInvent/features/Profile/presentation/addFamilyMember.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'FamilyMemberProfile.dart';
import 'package:MedInvent/features/Profile/services/dependent_service.dart';
import 'package:MedInvent/providers/authProvider.dart';

class FamilyMembers extends ConsumerStatefulWidget {
  const FamilyMembers({super.key});

  @override
  ConsumerState<FamilyMembers> createState() => _FamilyMembersState();
}

class _FamilyMembersState extends ConsumerState<FamilyMembers> {
  late Future<List<FamilyMember>> familyMembers;

  @override
  void initState() {
    super.initState();
    // fetchFamilyMembers();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchFamilyMembers(); // Moved it here
  }

  void fetchFamilyMembers() {
    setState(() {
      familyMembers = getFamilyMembers();
    });
  }

  Future<List<FamilyMember>> getFamilyMembers() async {
    try {
      var user = ref.watch(userProvider).user!;
      BaseClient baseClient = BaseClient();
      var response = await baseClient.get(
        '/DependMember/get/DependMembers/details/${user.userId}',
      );
      if (response != null) {
        return FamilyMember.userDependFromJson(response);
      } else {
        showPopupMessage(context,"no family members",Colors.redAccent);
        return [];
      }
    } catch (e) {
      showPopupMessage(context,"Process failed",Colors.redAccent);
      return [];
    }
  }

  Future<void> deleteFamilyMember(String id) async {
    try {
      BaseClient baseClient = BaseClient();
      await baseClient.delete('/DependMember/delete/DependMember/$id');
      fetchFamilyMembers(); // Refresh the list after
      showPopupMessage(context,"deleted successfully",Colors.green);
    } catch (e) {
      showPopupMessage(context,"Process failed",Colors.redAccent);
    }
  }

  void showPopupMessage(BuildContext context, String message, Color backgroundColor) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          content: Text(
            message,
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

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
                  FutureBuilder<List<FamilyMember>>(
                    future: familyMembers,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text("Error: ${snapshot.error}");
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.05,
                              vertical: screenHeight * 0.07),
                          child: Text(
                            "NO family member added yet",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: screenHeight * 0.02,
                                color: Colors.grey),
                          ),
                        );
                      } else {
                        return Column(
                          children: snapshot.data!
                              .map((e) => FamilyMemberCard(
                                    familyMember: e,
                                    onDelete: () => deleteFamilyMember(e.dID!),
                                  ))
                              .toList(),
                        );
                      }
                    },
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

  void _showDeleteConfirmationDialog(BuildContext context,Color backgroundColor) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: const Text(
              "Confirm Delete",
               style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize:20
            ),
          ),
          content:Text(
              "Are you sure you want to delete ${familyMember.fname} family member from your account?",
               style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize:17
               ),
          ),
          actions: [
            TextButton(
              child: const Text(
                  "Cancel",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize:17
                  ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(
                  "Delete",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize:17
                  ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                onDelete();
              },
            ),
          ],
        );
      },
    );
  }

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
                icon: Icon(Icons.delete, color: Colors.blue),
                onPressed:  () => _showDeleteConfirmationDialog(context,Colors.redAccent),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
