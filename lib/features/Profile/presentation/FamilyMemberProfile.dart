import 'package:flutter/material.dart';
import 'package:MedInvent/features/Profile/models/familyMember.dart';
import 'package:MedInvent/features/Profile/services/dependent_service.dart';
import 'package:intl/intl.dart';

class FamilyMemberProfile extends StatefulWidget {
  final FamilyMember familyMember;
  const FamilyMemberProfile({required this.familyMember, super.key});

  @override
  State<FamilyMemberProfile> createState() => FamilyMemberProfileState();
}

class FamilyMemberProfileState extends State<FamilyMemberProfile> {
  final TextEditingController _nicController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _fnameController = TextEditingController();
  final TextEditingController _lnameController = TextEditingController();
  final TextEditingController _relationshipController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nicController.text = widget.familyMember.nic ?? "N/A";
    _genderController.text = widget.familyMember.gender ?? "N/A";
    _dobController.text = widget.familyMember.dob != null
        ? DateFormat('dd-MM-yyyy').format(widget.familyMember.dob!)
        : "N/A";
    _fnameController.text = widget.familyMember.fname ?? "";
    _lnameController.text = widget.familyMember.lname ?? "";
    _relationshipController.text = widget.familyMember.relationship ?? "N/A";
  }

  void _updateDatabase() async {
    // Add your database update logic here
    print(
        "Database updated with NIC: ${_nicController.text}, Gender: ${_genderController.text}, DOB: ${_dobController.text}, First Name: ${_fnameController.text}, Last Name: ${_lnameController.text}, Relationship: ${_relationshipController.text}");

    try {
      widget.familyMember.nic = _nicController.text;
      widget.familyMember.gender = _genderController.text;
      widget.familyMember.dob = _dobController.text != "N/A"
          ? DateFormat('dd-MM-yyyy').parse(_dobController.text)
          : null;
      widget.familyMember.fname = _fnameController.text;
      widget.familyMember.lname = _lnameController.text;
      widget.familyMember.relationship = _relationshipController.text;

      BaseClient baseClient = BaseClient();
      var response = await baseClient.put(
          '/DependMember/update/DependMember/550e8400-e29b-41d4-a716-446655440000',
          widget.familyMember.toRawJson());
      if (response != null) {
        // Handle successful response
        print(response);
        //newDepend.receiverID=decodedJson ['data']['userID'];
        //print(newDepend.receiverID);
      } else {
        print('not success');
      }
    } catch (e) {
      // Handle error
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    String profilePic = "assets/images/pic.png";

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
          Container(
            margin: const EdgeInsets.only(top: 240.0),
            padding: const EdgeInsets.only(top: 10.0),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                    child: Container(
                      height: screenHeight * 0.38,
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
                          InfoField(
                            title: "First Name -:",
                            controller: _fnameController,
                            onUpdate: _updateDatabase,
                          ),
                          InfoField(
                            title: "Last Name -:",
                            controller: _lnameController,
                            onUpdate: _updateDatabase,
                          ),
                          InfoField(
                            title: "Relationship -:",
                            controller: _relationshipController,
                            onUpdate: _updateDatabase,
                          ),
                          SizedBox(
                            height: screenHeight * 0.008,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.025,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                    child: Container(
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
                        padding:
                            EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                        child: Column(
                          children: [
                            InfoField(
                              title: "NIC",
                              controller: _nicController,
                              onUpdate: _updateDatabase,
                            ),
                            InfoField(
                              title: "Gender",
                              controller: _genderController,
                              onUpdate: _updateDatabase,
                            ),
                            InfoField(
                              title: "Date of Birth",
                              controller: _dobController,
                              onUpdate: _updateDatabase,
                              isDob: true,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.025,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
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
                              fontSize: screenHeight * 0.015,
                              color: Colors.grey),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            left: screenWidth * 0.1,
            right: screenWidth * 0.1,
            top: screenHeight * 0.22,
            child: Container(
              height: 60.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(screenHeight * 0.04),
                  bottomRight: Radius.circular(screenHeight * 0.04),
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
            left: 0,
            right: 0,
            top: screenHeight * 0.17,
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

class InfoField extends StatefulWidget {
  final String title;
  final TextEditingController controller;
  final VoidCallback onUpdate;
  final bool isDob;

  const InfoField({
    Key? key,
    required this.title,
    required this.controller,
    required this.onUpdate,
    this.isDob = false,
  }) : super(key: key);

  @override
  InfoFieldState createState() => InfoFieldState();
}

class InfoFieldState extends State<InfoField> {
  bool isEditing = false;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != DateTime.now()) {
      setState(() {
        widget.controller.text = DateFormat('dd-MM-yyyy').format(picked);
        isEditing = false;
      });
      widget.onUpdate();
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.title,
            style: TextStyle(
                fontSize: screenHeight * 0.02, color: Colors.blue[900]),
          ),
          SizedBox(
            width: screenWidth * 0.29,
            child: isEditing
                ? widget.isDob
                    ? TextButton(
                        onPressed: () => _selectDate(context),
                        child: Text(
                          widget.controller.text,
                          style: TextStyle(
                              fontSize: screenHeight * 0.02,
                              color: Colors.black),
                        ),
                      )
                    : TextField(
                        controller: widget.controller,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.check),
                            onPressed: () {
                              setState(() {
                                isEditing = false;
                              });
                              widget.onUpdate();
                            },
                          ),
                        ),
                      )
                : Text(
                    widget.controller.text,
                    style: TextStyle(
                        fontSize: screenHeight * 0.02, color: Colors.black),
                  ),
          ),
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              setState(() {
                isEditing = true;
              });
            },
          ),
        ],
      ),
    );
  }
}
