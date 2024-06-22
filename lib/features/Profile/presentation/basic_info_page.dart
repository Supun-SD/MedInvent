import 'package:MedInvent/features/login/models/user_model.dart';
import 'package:MedInvent/providers/authProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:MedInvent/features/Profile/services/dependent_service.dart';
import 'dart:convert';

class BasicInfo extends ConsumerStatefulWidget {
  const BasicInfo({super.key});

  @override
  BasicInfoState createState() => BasicInfoState();
}

class BasicInfoState extends ConsumerState<BasicInfo> {
  final TextEditingController _fnameController = TextEditingController();
  final TextEditingController _lnameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _addressLine1Controller = TextEditingController();
  final TextEditingController _addressLine2Controller = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();

  @override
  void initState() {
    super.initState();
    var user = ref.read(userProvider)!;
    _fnameController.text = user.fname;
    _lnameController.text = user.lname;
    _dobController.text = user.dob;
    _genderController.text = user.gender;
    _addressLine1Controller.text = user.patientAddress.lineOne;
    _addressLine2Controller.text = user.patientAddress.lineTwo ?? "";
    _cityController.text = user.patientAddress.city;
    _districtController.text = user.patientAddress.district;
  }

  void _updateDatabase() async {
    try {
      var user = ref.read(userProvider)!;
      user.fname = _fnameController.text;
      user.lname = _lnameController.text;
      user.dob = _dobController.text;
      user.gender = _genderController.text;
      user.patientAddress.lineOne = _addressLine1Controller.text;
      user.patientAddress.lineTwo = _addressLine2Controller.text;
      user.patientAddress.city = _cityController.text;
      user.patientAddress.district = _districtController.text;

      // Update databse with the new user information
      BaseClient baseClient = BaseClient();
      User userOne = user;

      var response = await baseClient.put(
          '/PatientUser/update/PatientUser/${user.userId}',
          json.encode(userOne.toJson()));
      if (response != null) {
        baseClient = BaseClient();
      } else {
        print('Update not successful');
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
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
        title: const Text("Basic Information"),
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
            child: Container(
              margin: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.07,
                  vertical: screenHeight * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: CircleAvatar(
                      radius: screenHeight * 0.065,
                      backgroundImage:
                          const AssetImage('assets/images/pic.png'),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.03,
                  ),
                  Text(
                    "Basic Information",
                    style: TextStyle(
                        fontSize: screenHeight * 0.025,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  EditableInfoField(
                    label: "First Name",
                    controller: _fnameController,
                    onUpdate: _updateDatabase,
                  ),
                  EditableInfoField(
                    label: "Last Name",
                    controller: _lnameController,
                    onUpdate: _updateDatabase,
                  ),
                  EditableInfoField(
                    label: "Date of Birth",
                    controller: _dobController,
                    onUpdate: _updateDatabase,
                    isDob: true,
                  ),
                  EditableInfoField(
                    label: "Gender",
                    controller: _genderController,
                    onUpdate: _updateDatabase,
                  ),
                  SizedBox(
                    height: screenHeight * 0.03,
                  ),
                  Text(
                    "Secondary Information",
                    style: TextStyle(
                        fontSize: screenHeight * 0.025,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  EditableInfoField(
                    label: "Address Line 1",
                    controller: _addressLine1Controller,
                    onUpdate: _updateDatabase,
                  ),
                  EditableInfoField(
                    label: "Address Line 2",
                    controller: _addressLine2Controller,
                    onUpdate: _updateDatabase,
                  ),
                  EditableInfoField(
                    label: "City",
                    controller: _cityController,
                    onUpdate: _updateDatabase,
                  ),
                  EditableInfoField(
                    label: "District",
                    controller: _districtController,
                    onUpdate: _updateDatabase,
                  ),
                  SizedBox(
                    height: screenHeight * 0.09,
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

class EditableInfoField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final VoidCallback onUpdate;
  final bool isDob;

  const EditableInfoField({
    Key? key,
    required this.label,
    required this.controller,
    required this.onUpdate,
    this.isDob = false,
  }) : super(key: key);

  @override
  EditableInfoFieldState createState() => EditableInfoFieldState();
}

class EditableInfoFieldState extends State<EditableInfoField> {
  bool isEditing = false;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
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
      padding: EdgeInsets.all(screenWidth * 0.03),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: TextStyle(
              fontSize: screenHeight * 0.025,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: screenHeight * 0.01,
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Row(
              children: [
                Expanded(
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
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
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
                      : Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 10.0),
                          child: Text(
                            widget.controller.text,
                            style: TextStyle(
                              fontSize: screenHeight * 0.02,
                              color: Colors.black,
                            ),
                          ),
                        ),
                ),
                IconButton(
                  icon: const Icon(Icons.edit),
                  color: Colors.blue,
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
      ),
    );
  }
}
