import 'package:MedInvent/features/Register/presentation/validations.dart';
import 'package:MedInvent/components/custom_button.dart';
import 'package:MedInvent/components//input_field.dart';
import 'package:MedInvent/features/login/presentation/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:MedInvent/components/user_data.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Register3 extends StatefulWidget {
  final UserData userData;
  const Register3({super.key, required this.userData});

  @override
  State<Register3> createState() => _Register3State();
}

class _Register3State extends State<Register3> {
  final TextEditingController _addressLine1 = TextEditingController();
  final TextEditingController _addressLine2 = TextEditingController();
  final TextEditingController _city = TextEditingController();
  final TextEditingController _postalCode = TextEditingController();

  //function to dispose controllers when not in use
  @override
  void dispose() {
    _addressLine1.dispose();
    _addressLine2.dispose();
    _city.dispose();
    _postalCode.dispose();
    super.dispose();
  }

  // postData() async {
  //   var response = await http.post(
  //     //below i have added my PC IP  address "192.168.1.14" instead of adding localhost
  //     //since we are using pc emulator for checking purposes.
  //     //you can change it  to your PC IP address when you are going to work with this post method.
  //     Uri.parse("http://192.168.1.109:3300/user"),
  //     headers: {"Content-Type": "application/json"},
  //     body: jsonEncode({
  //       'email': widget.userData.email,
  //       'user_password': widget.userData.password,
  //       'first_name': widget.userData.firstName,
  //       'last_name': widget.userData.lastName,
  //       'nic': widget.userData.nic,
  //       'gender': widget.userData.gender,
  //       'birth_date': widget.userData.birthDate,
  //       'mNumber': widget.userData.mobileNumber,
  //       'address': {
  //         'line1': widget.userData.line1,
  //         'line2': widget.userData.line2,
  //         'city': widget.userData.city,
  //         'district': widget.userData.district,
  //         'postalCode': widget.userData.postalCode,
  //       }
  //     }),
  //   );
  //   print('Response status: ${response.statusCode}');
  //   print('Response body: ${response.body}');
  // }


  //registration successful message
  void _registrationSuccess() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text('Registration Successful'),
          content: const Text('You have successfully registered!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                  (route) => false,
                );
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  List<String> districts = [
    'Colombo',
    'Gampaha',
    'Kalutara',
    'Kandy',
    'Matale',
    'Nuwara Eliya',
    'Galle',
    'Matara',
    'Hambantota',
    'Jaffna',
    'Kilinochchi',
    'Mannar',
    'Mullaitivu',
    'Vavuniya',
    'Puttalam',
    'Kurunegala',
    'Anuradhapura',
    'Polonnaruwa',
    'Badulla',
    'Monaragala',
    'Ratnapura',
    'Kegalle',
    'Trincomalee',
    'Batticaloa',
    'Ampara',
  ];

  String selectedDistrict = "Colombo";

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Enter your residential address',
                  style: TextStyle(fontSize: screenHeight * 0.02),
                ),
                Text(
                  '(Optional)',
                  style: TextStyle(fontSize: screenHeight * 0.02),
                ),
                SizedBox(height: screenHeight * 0.07),
                InputField(
                    validator: (value) => emptyValidation(value, "Line 1"),
                    controller: _addressLine1,
                    keyboardType: TextInputType.text,
                    hint: 'Line 1',
                    isPassword: false),
                SizedBox(height: screenHeight * 0.02),
                InputField(
                    controller: _addressLine2,
                    keyboardType: TextInputType.text,
                    hint: 'Line 2 (Optional)',
                    isPassword: false),
                SizedBox(height: screenHeight * 0.02),
                InputField(
                    validator: (value) => emptyValidation(value, "City"),
                    controller: _city,
                    keyboardType: TextInputType.text,
                    hint: 'City',
                    isPassword: false),
                SizedBox(height: screenHeight * 0.02),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.12),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(screenWidth * 0.1),
                    ),
                    padding: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.003,
                        horizontal: screenWidth * 0.055),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: selectedDistrict,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedDistrict = newValue ?? 'Male';
                        });
                      },
                      underline: Container(),
                      items: districts.map((String gender) {
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
                ),
                SizedBox(height: screenHeight * 0.02),
                InputField(
                    controller: _postalCode,
                    keyboardType: TextInputType.number,
                    hint: 'Postal Code',
                    isPassword: false),
                SizedBox(height: screenHeight * 0.1),
                CustomButton(
                  text: 'Register',
                  onPressed: () {
                    widget.userData.line1 = _addressLine1.text;
                    widget.userData.line2 = _addressLine2.text;
                    widget.userData.city = _city.text;
                    widget.userData.district = selectedDistrict;
                    _registrationSuccess();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
