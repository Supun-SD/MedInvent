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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _addressLine1 = TextEditingController();
  final TextEditingController _addressLine2 = TextEditingController();
  final TextEditingController _city = TextEditingController();
  final TextEditingController _district = TextEditingController();
  final TextEditingController _postalCode = TextEditingController();

  postData() async {
    var response = await http.post(
      //below i have added my PC IP  address "192.168.1.14" instead of adding localhost
      //since we are using pc emulator for checking purposes.
      //you can change it  to your PC IP address when you are going to work with this post method.
      Uri.parse("http://192.168.1.109:3300/user"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        'user_password': widget.userData.password,
        'email': widget.userData.email,
        'first_name': widget.userData.first_name,
        'last_name': widget.userData.last_name,
        'nic': widget.userData.nic,
        'gender': widget.userData.gender,
        'birth_date': widget.userData.birth_date,
        'mNumber': widget.userData.mnumber,
        'address': {
          'line1': widget.userData.line1,
          'line2': widget.userData.line2,
          'city': widget.userData.city,
          'district': widget.userData.district,
          'postalCode': widget.userData.postalCode,
        }
      }),
    );
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
  }

  void _registrationSuccess() {
    postData();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
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

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

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
                SizedBox(height: screenHeight * 0.1),
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
                InputField(
                    validator: (value) => emptyValidation(value, "District"),
                    controller: _district,
                    keyboardType: TextInputType.text,
                    hint: 'District',
                    isPassword: false),
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
                    if (_formKey.currentState?.validate() == true) {
                      widget.userData.line1 = _addressLine1.text;
                      widget.userData.line2 = _addressLine2.text;
                      widget.userData.city = _city.text;
                      widget.userData.district = _district.text;
                      widget.userData.postalCode = int.parse(_postalCode.text);
                      _registrationSuccess();
                    }
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
