import 'package:MedInvent/config/api.dart';
import 'package:MedInvent/features/login/presentation/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:MedInvent/components/custom_button.dart';
import 'package:MedInvent/components//input_field.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../../providers/nearbyPharmaciesAndDoctorsProvider.dart';

class PasswordReset extends StatefulWidget {
  const PasswordReset({super.key});

  @override
  State<PasswordReset> createState() => _PasswordResetState();
}

class _PasswordResetState extends State<PasswordReset> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _nic = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isLoading = false;
  String? userId;

  //function to dispose controllers when not in use
  @override
  void dispose() {
    _email.dispose();
    _nic.dispose();
    super.dispose();
  }

  //function to check if email and nic is matching
  Future<bool?> checkEmailAndNic() async {
    String apiUrl =
        '${ApiConfig.baseUrl}/patientuser/check/emailandnic?email=${_email.text}&nic=${_nic.text}';
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        if (jsonResponse['data']['success'] == false) {
          return false;
        } else {
          userId = jsonResponse['data']['userID'];
          return true;
        }
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<void> sendResetLink(String userId) async {
    final response = await http
        .get(Uri.parse('${ApiConfig.baseUrl}/user/resetPassword/$userId'));

    if (response.statusCode == 200) {
      _successfulDialog();
    } else {
      throw Exception('Failed to validate');
    }
  }

  //function to verify details
  Future<void> verification() async {
    if (_nic.text.isEmpty || _email.text.isEmpty) {
      scaffoldMessengerKey.currentState?.showSnackBar(
        const SnackBar(
          content: Text("Email or NIC cannot be empty"),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }
    setState(() {
      isLoading = true;
    });

    var isValid = await checkEmailAndNic();

    setState(() {
      isLoading = false;
    });

    if (isValid == true) {
      setState(() {
        isLoading = true;
      });

      await sendResetLink(userId!);

      setState(() {
        isLoading = false;
      });
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

  void _successfulDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text('Password Reset Link Sent'),
          content: const Text(
              "Please check your email for a password reset link. Follow the instructions provided to reset your password. If you don't see the email in your inbox, check your spam folder.",
              textAlign: TextAlign.justify),
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

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text('Password reset failed'),
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
                      hint: 'Email',
                      isPassword: false),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  InputField(
                      controller: _nic,
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
