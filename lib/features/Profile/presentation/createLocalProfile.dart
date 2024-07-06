import 'package:MedInvent/features/Profile/models/familyMember.dart';
import 'package:MedInvent/providers/authProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';
import 'package:MedInvent/features/Profile/services/dependent_service.dart';

// create new depend profile page
class CreateLocalProfile extends ConsumerStatefulWidget {
  const CreateLocalProfile({super.key});
  @override
  ConsumerState<CreateLocalProfile> createState() => _CreateLocalProfileState();
}

class _CreateLocalProfileState extends ConsumerState<CreateLocalProfile> {
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController relationship = TextEditingController();
  TextEditingController nic = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    firstName.dispose();
    lastName.dispose();
    relationship.dispose();
    nic.dispose();
    super.dispose();
  }

  final List<String> genderOptions = ['Male', 'Female'];
  String selectedGender = 'Male';
  DateTime selectedDate = DateTime.now();
  String displayText = "Date of Birth";

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        displayText = "${picked.toLocal()}".split(' ')[0];
      });
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
    final double keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    return Form(
      key: _formKey,
      child: Container(
        height: screenHeight * 0.75 + keyboardSpace,
        margin: EdgeInsets.only(
            top: screenHeight * 0.05,
            left: screenWidth * 0.15,
            right: screenWidth * 0.15),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Create a local account",
                style: TextStyle(fontSize: screenWidth * 0.045),
              ),
              SizedBox(
                height: screenHeight * 0.05,
              ),
              SizedBox(
                height: screenHeight * 0.035,
              ),
              Input(label: "First name", controller: firstName),
              SizedBox(
                height: screenHeight * 0.015,
              ),
              Input(label: "Last name", controller: lastName),
              SizedBox(
                height: screenHeight * 0.015,
              ),
              Input(label: "Relationship", controller: relationship),
              SizedBox(
                height: screenHeight * 0.015,
              ),
              Input(label: "NIC", controller: nic),
              SizedBox(
                height: screenHeight * 0.015,
              ),
              Row(
                children: [
                  Container(
                    height: screenHeight * 0.05,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(screenWidth * 0.1),
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: screenWidth * 0.045),
                    child: DropdownButton<String>(
                      value: selectedGender,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedGender = newValue ?? 'Male';
                        });
                      },
                      underline: Container(),
                      items: genderOptions.map((String gender) {
                        return DropdownMenuItem<String>(
                          value: gender,
                          child: Text(gender),
                        );
                      }).toList(),
                      elevation: 16,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20.0)),
                    ),
                  ),
                  SizedBox(
                    width: screenWidth * 0.03,
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () => _selectDate(context),
                      child: Container(
                        height: screenHeight * 0.05,
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.035,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              displayText,
                              style: TextStyle(fontSize: screenWidth * 0.035),
                            ),
                            const Spacer(),
                            const Icon(
                              Icons.calendar_month,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: screenHeight * 0.05,
              ),
              TextButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate() &&
                      displayText != "Date of Birth") {
                    // Create a new FamilyMember instance
                    FamilyMember newMember = FamilyMember(
                        firstName.text,
                        lastName.text,
                        selectedDate,
                        selectedGender,
                        "not added",
                        nic.text,
                        [],
                        relationship.text,
                        "");

                    // Send the new member data to the backend
                    try {
                      BaseClient baseClient = BaseClient();
                      var response = await baseClient.post(
                        '/DependMember/add/new/DependMember/${ref.watch(userProvider).user!.userId}',
                        newMember.toRawJsonCreate(),
                      );
                      if (response != null) {
                        Navigator.pop(context);
                        print(response);
                        showPopupMessage(context, "New depend Added Successfully", Colors.green); // Success popup
                      }
                    } catch (e) {
                      showPopupMessage(context, "Process Failed", Colors.redAccent); // error popup
                      print("Error: $e");
                    }

                  }else{
                    showPopupMessage(context, "Process Failed", Colors.redAccent); // error popup
                  }
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
              SizedBox(
                height: screenHeight * 0.03,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Input extends StatelessWidget {
  final String label;
  final TextEditingController controller;

  const Input({Key? key, required this.label, required this.controller})
      : super(key: key);

  String? _validateInput(String? value) {
    final RegExp lettersOnly = RegExp(r'^[a-zA-Z]+$');
    final RegExp noSymbols = RegExp(r'^[a-zA-Z0-9]+$');

    if (value == null || value.isEmpty) {
      return 'This field cannot be empty';
    }
    if (label == "First name" || label == "Last name" || label == "Relationship") {
      if (!lettersOnly.hasMatch(value)) {
        return 'Only letters are allowed';
      }
    }
    if (label == "NIC" && !noSymbols.hasMatch(value)) {
      return 'NIC cannot contain symbols';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return TextFormField(
      controller: controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: _validateInput,
      decoration: InputDecoration(
        labelText: label,
        contentPadding: EdgeInsets.only(left: screenWidth * 0.05),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      ),
    );
  }
}
