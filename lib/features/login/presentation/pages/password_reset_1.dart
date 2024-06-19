import 'package:MedInvent/config/api.dart';
import 'package:flutter/material.dart';
import 'package:MedInvent/features/login/presentation/pages/password_reset_2.dart';
import 'package:MedInvent/components/custom_button.dart';
import 'package:MedInvent/components//input_field.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../../providers/nearbyPharmaciesAndDoctorsProvider.dart';

class PasswordReset1 extends StatefulWidget {
  const PasswordReset1({super.key});

  @override
  State<PasswordReset1> createState() => _PasswordReset1State();
}

class _PasswordReset1State extends State<PasswordReset1> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _NIC = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isLoading = false;

  //function to dispose controllers when not in use
  @override
  void dispose() {
    _email.dispose();
    _NIC.dispose();
    super.dispose();
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

  //function to check if email and nic is matching
  Future<bool?> checkEmailAndNic() async {
    String apiUrl =
        '${ApiConfig.baseUrl}/patientuser/check/emailandnic?email=${_email.text}&nic=${_NIC.text}';

    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);

        if (jsonResponse['data']['success'] == false) {
          return false;
        } else {
          return true;
        }
      } else {
        return null;
      }
    } catch (e) {
      return null;
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  //function to verify details
  Future<void> verification() async {
    if (_NIC.text.isEmpty || _email.text.isEmpty) {
      scaffoldMessengerKey.currentState?.showSnackBar(
        const SnackBar(
          content: Text("Email or NIC cannot be empty"),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    var isValid = await checkEmailAndNic();

    if (isValid == true) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const PasswordReset2()),
      );
    } else if (isValid == null) {
      scaffoldMessengerKey.currentState?.showSnackBar(
        const SnackBar(
          content: Text("Fail to validate"),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      _showErrorDialog("Entered email and NIC does not match");
    }
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
                children: [
                  Text(
                    'Reset your password',
                    style: TextStyle(
                      fontSize: screenHeight * 0.025,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.25,
                        vertical: screenHeight * 0.05),
                    child: Image.asset('assets/images/pwreset.jpg'),
                  ),
                  InputField(
                      controller: _email,
                      keyboardType: TextInputType.text,
                      prefixIcon: const Icon(Icons.person),
                      hint: 'Email/Phone No.',
                      isPassword: false),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  InputField(
                      controller: _NIC,
                      keyboardType: TextInputType.text,
                      prefixIcon: const Icon(Icons.tag),
                      hint: 'NIC',
                      isPassword: false),
                  SizedBox(height: screenHeight * 0.07),
                  isLoading
                      ? const SpinKitCircle(
                          size: 35,
                          color: Colors.blue,
                        )
                      : CustomButton(
                          text: 'Reset Password', onPressed: verification),
                ],
              ),
            ),
          ),
        ));
  }
}
