import 'package:MedInvent/features/Profile/presentation/tempBasic.dart';
import 'package:MedInvent/providers/authProvider.dart';
import 'package:flutter/material.dart';
import 'package:MedInvent/components/input_field_edit.dart';
import 'package:MedInvent/components/Savebutton.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../providers/nearbyPharmaciesAndDoctorsProvider.dart';

class SecurityInfo extends ConsumerStatefulWidget {
  const SecurityInfo({super.key});

  @override
  ConsumerState<SecurityInfo> createState() => SecurityInfoState();
}

class SecurityInfoState extends ConsumerState<SecurityInfo> {
  bool isLoading = false;
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  Future<void> resetPassword(String username, String userId) async {
    if (password.text.isEmpty || confirmPassword.text.isEmpty) {
      _showSnackBar("Fields cannot be empty", 'error');
      return;
    }

    if (password.text != confirmPassword.text) {
      _showSnackBar("Passwords don't match", 'error');
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final tokenResponse = await http.post(
        Uri.parse(
            'https://lemur-4.cloud-iam.com/auth/realms/gl-medinvent/protocol/openid-connect/token'),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'username': 'admin',
          'password': 'medinventadmin',
          'client_id': "medinvent",
          'client_secret': 'ZmWKbKEEeLU9xVSLbGw0ytclsy0iz1WJ',
          'grant_type': 'password',
          'scope': 'openid'
        },
      );

      if (tokenResponse.statusCode != 200) {
        throw Exception('Failed to refresh token');
      }

      final accessToken = jsonDecode(tokenResponse.body)['access_token'];

      final payload = jsonEncode({
        'type': 'password',
        'value': password.text,
        'temporary': false,
      });

      final response = await http.put(
        Uri.parse(
            'https://lemur-4.cloud-iam.com/auth/admin/realms/gl-medinvent/users/$userId/reset-password'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: payload,
      );

      if (response.statusCode != 204) {
        throw Exception('Failed to reset password');
      }

      _showSnackBar('Password reset successfully', 'success');
    } catch (e) {
      print(e.toString());
      _showSnackBar('Failed to reset password.', 'error');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _showSnackBar(String text, String type) {
    scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(text),
        backgroundColor: type == 'error' ? Colors.red : Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    var user = ref.watch(userProvider).user!;

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
        title: const Text("Security Information"),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF474CA0),
                Color(0xFF468FA0),
              ],
            ),
          ),
          child: Container(
            margin: EdgeInsets.only(top: screenHeight * 0.025),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50.0),
                  topRight: Radius.circular(50.0),
                )),
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.07,
                ),
                child: Column(
                  children: [
                    const AddText(
                      text: 'Security Information',
                      topValue: 41.8,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: screenHeight * 0.02,
                          horizontal: screenWidth * 0.02),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 0,
                            blurRadius: 70,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Info(
                            label: "Email",
                            data: user.email,
                          ),
                          Info(
                            label: "Mobile Number",
                            data: user.mobileNo,
                          ),
                          Info(
                            label: "Nic",
                            data: user.nic,
                          ),
                        ],
                      ),
                    ),
                    const AddText(
                      text: 'Change Password',
                      topValue: 41.8,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.02,
                          vertical: screenHeight * 0.04),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 0,
                            blurRadius: 70,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Inputbutton(
                            topic: 'New Password',
                            bvalue: 24,
                            wiht: 300,
                            controller: password,
                          ),
                          Inputbutton(
                            topic: 'Confirm Password',
                            wiht: 300,
                            controller: confirmPassword,
                          ),
                        ],
                      ),
                    ),
                    if (isLoading)
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: screenHeight * 0.05),
                        child: const SpinKitCircle(
                          size: 25,
                          color: Colors.blue,
                        ),
                      )
                    else
                      SaveButton(
                        onTap: () {
                          resetPassword(user.email, user.userId);
                        },
                        save: 'Update',
                      ),
                    SizedBox(height: screenHeight * 0.07),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AddText extends StatelessWidget {
  const AddText({
    super.key,
    required this.text,
    this.topValue = 0.0,
  });
  final String text;
  final double topValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      margin: EdgeInsets.only(top: topValue, left: 10, bottom: 15),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 20,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
