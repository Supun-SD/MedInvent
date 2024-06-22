import 'package:MedInvent/components/custom_button.dart';
import 'package:MedInvent/components/input_field.dart';
import 'package:MedInvent/config/api.dart';
import 'package:MedInvent/features/Register/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:MedInvent/features/Register/presentation/register_2.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../validations.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Register1 extends StatefulWidget {
  final User user = User();
  Register1({super.key});

  @override
  State<Register1> createState() => _Register1State();
}

class _Register1State extends State<Register1> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _mobileNo = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();

  bool isLoading = false;

  //function to convert the mobile number with country code
  String convertMobileNumber(String number) {
    return '+94${number.substring(1)}';
  }

  //function to dispose controllers when not in use
  @override
  void dispose() {
    _email.dispose();
    _mobileNo.dispose();
    _password.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }

  Future<bool> checkEmailAndMobileNo() async {
    String apiUrl =
        '${ApiConfig.baseUrl}/patientuser/check/emailandmobileno?email=${_email.text}&mobileNo=%2B94${_mobileNo.text.substring(1)}';

    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);

        if (jsonResponse['data']['message'] == "Patient not found") {
          return true;
        } else {
          _showErrorDialog("This mobile number or email is already used");
        }
      } else {
        _showErrorDialog("Failed to check availability");
      }
    } catch (e) {
      _showErrorDialog("Error: $e");
      return false;
    } finally {
      setState(() {
        isLoading = false;
      });
    }
    return false;
  }

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
              children: <Widget>[
                Text(
                  "Welcome to MedInvent",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: screenHeight * 0.025,
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.01,
                ),
                Text(
                  "Please register to continue",
                  style: TextStyle(
                    fontSize: screenHeight * 0.02,
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.1,
                ),
                InputField(
                    validator: validateEmail,
                    controller: _email,
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: const Icon(Icons.email_outlined),
                    hint: 'Email',
                    isPassword: false),
                SizedBox(height: screenHeight * 0.02),
                InputField(
                    validator: validateMobileNo,
                    controller: _mobileNo,
                    keyboardType: TextInputType.number,
                    prefixIcon: const Icon(Icons.phone),
                    hint: 'Mobile No.',
                    isPassword: false),
                SizedBox(height: screenHeight * 0.02),
                InputField(
                    validator: (value) => validatePassword(value),
                    controller: _password,
                    keyboardType: TextInputType.text,
                    prefixIcon: const Icon(Icons.lock_open),
                    hint: 'Password',
                    isPassword: true),
                SizedBox(height: screenHeight * 0.02),
                InputField(
                    validator: (value) =>
                        confirmPassword(value, _password.text),
                    controller: _confirmPassword,
                    keyboardType: TextInputType.text,
                    prefixIcon: const Icon(Icons.lock_open),
                    hint: 'Confirm Password',
                    isPassword: true),
                SizedBox(height: screenHeight * 0.08),
                if (isLoading)
                  SpinKitThreeBounce(
                    size: screenWidth * 0.06,
                    color: const Color(0xFF2980B9),
                  )
                else
                  CustomButton(
                    text: 'Next',
                    onPressed: () async {
                      if (_formKey.currentState?.validate() == true) {
                        bool isAvailable = await checkEmailAndMobileNo();

                        if (mounted) {
                          if (isAvailable) {
                            widget.user.email = _email.text;
                            widget.user.mobileNo =
                                convertMobileNumber(_mobileNo.text);
                            widget.user.password = _password.text;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Register2(user: widget.user)),
                            );
                          }
                        }
                      }
                    },
                  ),
                SizedBox(height: screenHeight * 0.04),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: screenHeight * 0.016),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Sign in',
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: screenHeight * 0.016),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
