import 'package:flutter/material.dart';
import 'package:MedInvent/components/custom_button.dart';
import 'package:MedInvent/components//input_field.dart';
import 'package:MedInvent/features/login/presentation/pages/login.dart';
import 'package:MedInvent/features/Register/presentation/validations.dart';
import 'package:MedInvent/components/user_data.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Register4 extends StatefulWidget {
  final UserData usedata;
  const Register4({super.key, required this.usedata});

  @override
  State<Register4> createState() => _Register4State();
}

class _Register4State extends State<Register4> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _dob = TextEditingController();
  final TextEditingController _height = TextEditingController();
  final TextEditingController _weight = TextEditingController();

  void _registrationSuccess() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Registration Successful'),
          content: const Text('You have successfully registered!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // close the dialog
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => LoginPage()),
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

    final double screenWidth = MediaQuery.of(context).size.width;
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
                  'Enter your demographic details',
                  style: TextStyle(fontSize: screenHeight * 0.02),
                ),
                SizedBox(height: screenHeight * 0.1),
                InputField(
                    validator: (value) => dobValidation(value),
                    controller: _dob,
                    keyboardType: TextInputType.datetime,
                    hint: 'Date of Birth (YYYY-MM-DD)',
                    isPassword: false),
                SizedBox(height: screenHeight * 0.02),
                InputField(
                    controller: _height,
                    keyboardType: TextInputType.number,
                    hint: 'Height (cm)',
                    isPassword: false),
                SizedBox(height: screenHeight * 0.02),
                InputField(
                    controller: _weight,
                    keyboardType: TextInputType.number,
                    hint: 'Weight (Kg)',
                    isPassword: false),
              SizedBox(height: screenHeight * 0.1),
                CustomButton(
                  text: 'Register',
                  onPressed: () {
                    if (_formKey.currentState?.validate() == true) {
                      widget.usedata.birth_date = _dob.text;
                      widget.usedata.height = _height.text;
                      widget.usedata.weight = _weight.text;
                      postData();
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
  postData() async{
    var response = await http.post(
      //below i have added my PC IP  address "192.168.1.14" instead of adding localhost
      //since we are using pc emulator for checking purposes.
      //you can change it  to your PC IP address when you are going to work with this post method.
        Uri.parse("http://192.168.1.14:3300/user"),
        headers: {"Content-Type": "application/json"},
        body:jsonEncode({
          'user_password':widget.usedata.password,
          'email':widget.usedata.email,
          'first_name':widget.usedata.first_name,
          'last_name':widget.usedata.last_name,
          'nic':widget.usedata.nic,
          'gender':widget.usedata.gender,
          'weight':widget.usedata.weight,
          'birth_date':widget.usedata.birth_date,
          'height':widget.usedata.height,
          'mnumber':widget.usedata.mnumber,
        }),
    );
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
  }

}


