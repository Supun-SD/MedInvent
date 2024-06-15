import 'package:flutter/material.dart';
import 'package:MedInvent/features/Profile/data/models/familyMember.dart';
import 'package:MedInvent/features/Profile/services/dependent_service.dart';
import 'dart:convert';
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
    print("Database updated with NIC: ${_nicController.text}, Gender: ${_genderController.text}, DOB: ${_dobController.text}, First Name: ${_fnameController.text}, Last Name: ${_lnameController.text}, Relationship: ${_relationshipController.text}");

    try {
      widget.familyMember.nic = _nicController.text;
      widget.familyMember.gender = _genderController.text ?? "N/A";
      widget.familyMember.dob = _dobController.text != "N/A"
          ? DateFormat('dd-MM-yyyy').parse(_dobController.text)
          : null;
      widget.familyMember.fname = _fnameController.text ?? "";
      widget.familyMember.lname = _lnameController.text ?? "";
      widget.familyMember.relationship = _relationshipController.text ?? "N/A";

      BaseClient baseClient = BaseClient();
      var response = await baseClient.put(
          '/DependMember/update/DependMember/126b4f01-e486-461e-b20e-311e3c7c0ffb',
          widget.familyMember.toRawJson()
      );
      if (response != null) {
        // Handle successful response
        print(response);
        Map<String, dynamic> decodedJson = json.decode(response);
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
            top: screenHeight * 0.3,
            right: 0,
            left: 0,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
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
                          title: "First Name",
                          controller: _fnameController,
                          onUpdate: _updateDatabase,
                        ),
                        InfoField(
                          title: "Last Name",
                          controller: _lnameController,
                          onUpdate: _updateDatabase,
                        ),
                        InfoField(
                          title: "Relationship",
                          controller: _relationshipController,
                          onUpdate: _updateDatabase,
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
                      padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
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
  _InfoFieldState createState() => _InfoFieldState();
}

class _InfoFieldState extends State<InfoField> {
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
      padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.title,
            style: TextStyle(fontSize: screenHeight * 0.02, color: Colors.blue[900]),
          ),
          SizedBox(
            width: screenWidth * 0.29,
            child: isEditing
                ? widget.isDob
                ? TextButton(
              onPressed: () => _selectDate(context),
              child: Text(
                widget.controller.text,
                style: TextStyle(fontSize: screenHeight * 0.02, color: Colors.black),
              ),
            )
                : TextField(
              controller: widget.controller,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: Icon(Icons.check),
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
              style: TextStyle(fontSize: screenHeight * 0.02, color: Colors.black),
            ),
          ),
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              setState(() {
                isEditing = true;
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              setState(() {
                widget.controller.clear();
              });
              widget.onUpdate();
            },
          ),
        ],
      ),
    );
  }
}
