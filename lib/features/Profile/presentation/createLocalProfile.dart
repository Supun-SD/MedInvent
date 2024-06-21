import 'package:MedInvent/features/Profile/data/datasources/familyMembers.dart';
import 'package:MedInvent/features/Profile/data/models/familyMember.dart';
import 'package:MedInvent/providers/authProvider.dart';
import 'package:MedInvent/providers/familyMembersProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
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

  File? _image;

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

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
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
              Row(
                children: [
                  _image == null
                      ? CircleAvatar(
                          radius: screenWidth * 0.1,
                          backgroundColor: const Color(0xFF2980B9),
                          child: Icon(
                            Icons.add_photo_alternate_outlined,
                            size: screenWidth * 0.1,
                            color: Colors.white,
                          ),
                        )
                      : CircleAvatar(
                          radius: screenWidth * 0.1,
                          backgroundImage: FileImage(_image!),
                        ),
                  SizedBox(
                    width: screenWidth * 0.07,
                  ),
                  TextButton(
                    onPressed: () {
                      _pickImage();
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
                        "Upload a photo",
                        style: TextStyle(
                            color: const Color(0xFF2980B9),
                            fontSize: screenHeight * 0.015),
                      ),
                    ),
                  ),
                ],
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
                      _image?.path,
                      nic.text,
                      [],
                      relationship.text,
                      ""
                    );

                    // Send the new member data to the backend
                    try {
                      BaseClient baseClient = BaseClient();
                      var response = await baseClient.post(
                        '/DependMember/add/new/DependMember/${ref.watch(userProvider)!.userId}',
                        newMember.toRawJsonCreate(),
                      );
                      if (response != null) {
                        // Handle successful response
                        print(response);
                        Navigator.pop(context);
                      }
                    } catch (e) {
                      // Handle error
                      print("Error: $e");
                    }

                    //give code to filll here
                    // ref.read(familyMembersProvider.notifier).addFamilyMember(
                    //     FamilyMember(
                    //         "${firstName.text} ${lastName.text}",
                    //         relationship.text,
                    //         nic.text,
                    //         selectedGender,
                    //         displayText, []));
                    // Navigator.pop(context);

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
    if (label == "First name" ||
        label == "Last name" ||
        label == "Relationship") {
      if (value == null || value.isEmpty) {
        return 'This field cannot be empty';
      }
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
