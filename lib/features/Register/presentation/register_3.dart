import 'package:MedInvent/config/api.dart';
import 'package:MedInvent/features/Register/models/user_model.dart';
import 'package:MedInvent/features/Register/validations.dart';
import 'package:MedInvent/components/custom_button.dart';
import 'package:MedInvent/components//input_field.dart';
import 'package:MedInvent/features/login/presentation/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Register3 extends StatefulWidget {
  final User user;
  const Register3({super.key, required this.user});

  @override
  State<Register3> createState() => _Register3State();
}

class _Register3State extends State<Register3> {
  final TextEditingController _addressLine1 = TextEditingController();
  final TextEditingController _addressLine2 = TextEditingController();
  final TextEditingController _city = TextEditingController();
  final TextEditingController _postalCode = TextEditingController();

  bool isLoading = false;

  //function to dispose controllers when not in use
  @override
  void dispose() {
    _addressLine1.dispose();
    _addressLine2.dispose();
    _city.dispose();
    _postalCode.dispose();
    super.dispose();
  }

  Future<void> postData() async {
    String apiUrl = '${ApiConfig.baseUrl}/patientuser/add/new/patientuser';
    setState(() {
      isLoading = true;
    });
    try {
      var response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          'userDetails': {
            'Fname': widget.user.fName,
            'Lname': widget.user.lName,
            'mobileNo': widget.user.mobileNo,
            'email': widget.user.email,
            'nic': widget.user.nic,
            'gender': widget.user.gender,
            'dob': widget.user.dob,
            'patientAddress': {
              'lineOne': widget.user.lineOne,
              'lineTwo': widget.user.lineTwo,
              'city': widget.user.city,
              'district': widget.user.district,
              'postalCode': widget.user.postalCode,
            }
          },
          'credentials': {
            'email': widget.user.email,
            'mobileNo': widget.user.mobileNo,
            'password': widget.user.password,
          }
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        _registrationSuccess();
      } else {
        _showErrorDialog('Registration failed. Please try again.');
      }
    } catch (error) {
      _showErrorDialog('An error occurred. Please try again.');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  // Registration successful message
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

  // Show error message
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text('Registration Failed'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
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

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
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
                    hint: 'Postal Code (Optional)',
                    isPassword: false),
                SizedBox(height: screenHeight * 0.1),
                isLoading
                    ? SpinKitThreeBounce(
                        size: screenWidth * 0.06,
                        color: const Color(0xFF2980B9),
                      )
                    : CustomButton(
                        text: 'Register',
                        onPressed: () {
                          if (_formKey.currentState?.validate() == false) {
                            return;
                          }
                          widget.user.lineOne = _addressLine1.text;
                          widget.user.lineTwo = _addressLine2.text;
                          widget.user.city = _city.text;
                          widget.user.district = selectedDistrict;
                          widget.user.postalCode = _postalCode.text;
                          postData();
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
