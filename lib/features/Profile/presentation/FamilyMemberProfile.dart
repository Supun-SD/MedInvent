import 'package:flutter/material.dart';
import 'package:MedInvent/features/Profile/models/familyMember.dart';
import 'package:MedInvent/features/Profile/services/dependent_service.dart';
import 'package:intl/intl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:MedInvent/providers/authProvider.dart';


class FamilyMemberProfile extends ConsumerStatefulWidget {
  final FamilyMember familyMember;
  const FamilyMemberProfile({required this.familyMember, super.key});

  @override
  ConsumerState<FamilyMemberProfile> createState() => FamilyMemberProfileState();
}

class FamilyMemberProfileState extends ConsumerState<FamilyMemberProfile> {
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

  bool _validateInputs() {
    final nameRegex = RegExp(r'^[a-zA-Z]+$');
    final nicRegex = RegExp(r'^[a-zA-Z0-9]+$'); // Adjust as per NIC validation rules

    if (_fnameController.text.isEmpty ||
        _lnameController.text.isEmpty ||
        _relationshipController.text.isEmpty ||
        _nicController.text.isEmpty ||
        _genderController.text.isEmpty) {
      showPopupMessage(context, "All fields must be filled", Colors.redAccent);
      return false;
    }

    if (!nameRegex.hasMatch(_fnameController.text)) {
      showPopupMessage(context, "First name can contain only letters", Colors.redAccent);
      return false;
    }

    if (!nameRegex.hasMatch(_lnameController.text)) {
      showPopupMessage(context, "Last name can contain only letters", Colors.redAccent);
      return false;
    }

    if (!nameRegex.hasMatch(_relationshipController.text)) {
      showPopupMessage(context, "Relationship can contain only letters", Colors.redAccent);
      return false;
    }

    if (!nicRegex.hasMatch(_nicController.text)) {
      showPopupMessage(context, "NIC cannot contain symbols", Colors.redAccent);
      return false;
    }

    if (!nameRegex.hasMatch(_genderController.text)) {
      showPopupMessage(context, "Gender can contain only letters", Colors.redAccent);
      return false;
    }

    return true;
  }

  void _updateDatabase() async {
    if (!_validateInputs()) {
      return;
    }
    try {
      widget.familyMember.nic = _nicController.text;
      widget.familyMember.gender = _genderController.text;
      widget.familyMember.dob = _dobController.text != "N/A"
          ? DateFormat('dd-MM-yyyy').parse(_dobController.text)
          : null;
      widget.familyMember.fname = _fnameController.text;
      widget.familyMember.lname = _lnameController.text;
      widget.familyMember.relationship = _relationshipController.text;

      var user = ref.read(userProvider).user!;
      BaseClient baseClient = BaseClient();
      var response = await baseClient.put(
          '/DependMember/update/DependMember/${user.userId}',
          widget.familyMember.toRawJson());
      if (response != null) {
        print(response);
        showPopupMessage(context,"updated successfully",Colors.green);
      } else {
        showPopupMessage(context,"updating Process failed",Colors.redAccent);
      }
    } catch (e) {
      showPopupMessage(context,"updating Process failed",Colors.redAccent);
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
                      padding: EdgeInsets.fromLTRB(10, 8, 10, 2),
                      height: screenHeight * 0.54,
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
                            height: screenHeight * 0.03,
                          ),
                          InfoField(
                            title: "First Name -:",
                            controller: _fnameController,
                            onUpdate: _updateDatabase,
                          ),
                          SizedBox(
                            height: screenHeight * 0.02,
                          ),
                          InfoField(
                            title: "Last Name -:",
                            controller: _lnameController,
                            onUpdate: _updateDatabase,
                          ),
                          SizedBox(
                            height: screenHeight * 0.02,
                          ),
                          InfoField(
                            title: "Relationship -:",
                            controller: _relationshipController,
                            onUpdate: _updateDatabase,
                          ),
                          SizedBox(
                            height: screenHeight * 0.02,
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
                      padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
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
                            SizedBox(
                              height: screenHeight * 0.03,
                            ),
                            InfoField(
                              title: "NIC",
                              controller: _nicController,
                              onUpdate: _updateDatabase,
                            ),
                            SizedBox(
                              height: screenHeight * 0.02,
                            ),
                            InfoField(
                              title: "Gender",
                              controller: _genderController,
                              onUpdate: _updateDatabase,
                            ),
                            SizedBox(
                              height: screenHeight * 0.02,
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: TextStyle(
              fontSize: screenHeight * 0.023,
              color: Colors.black,
              fontWeight: FontWeight.bold
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blue),
            borderRadius: BorderRadius.circular(10.0),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          margin: const EdgeInsets.symmetric(vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: isEditing
                    ? widget.isDob
                    ? TextButton(
                  onPressed: () => _selectDate(context),
                  child: Text(
                    widget.controller.text,
                    style: TextStyle(
                        fontSize: screenHeight * 0.021,
                        color: Colors.black),
                  ),
                )
                    : TextField(
                  controller: widget.controller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
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
                      fontSize: screenHeight * 0.025, color: Colors.black),
                ),
              ),
              IconButton(
                icon: Icon(Icons.edit, color: Colors.blue),
                onPressed: () {
                  setState(() {
                    isEditing = true;
                  });
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

