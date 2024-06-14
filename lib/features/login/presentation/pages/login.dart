import 'dart:convert';

import 'package:MedInvent/features/home/presentation/mainPage.dart';
import 'package:MedInvent/features/login/data/models/user_model.dart';
import 'package:MedInvent/providers/authProvider.dart';
import 'package:flutter/material.dart';
import 'package:MedInvent/features/login/presentation/pages/password_reset_1.dart';
import 'package:MedInvent/components/input_field.dart';
import 'package:MedInvent/features/Register/presentation/pages/register_1.dart';
import 'package:MedInvent/components/custom_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  //temporary username ans password
  final String username = "admin";
  final String password = "admin";

  bool isLoading = false;

  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  //function to dispose controllers when not in use
  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  //pop to show when invalid credentials are entered
  Future<void> _invalidCredentials() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text('Invalid login credentials.'),
          content: const Text(
              'Please enter a valid email or mobile number and password.'),
          actions: <Widget>[
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

  //function to authenticate login
  void loginAuth(BuildContext context) async {
    if (_email.text.isEmpty || _password.text.isEmpty) return;

    if (_email.text == username && _password.text == password) {
      setState(() {
        isLoading = true;
      });
      try {
        User user = await ref
            .read(userProvider.notifier)
            .loginUser(_email.text, _password.text);
        await _onLoginSuccess(username, password, user);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const Home(
              sideNavIndex: 2,
            ),
          ),
          (Route<dynamic> route) => false,
        );
      } catch (e) {
        _invalidCredentials();
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    } else {
      _invalidCredentials();
      _email.clear();
      _password.clear();
    }
  }

  Future<void> _onLoginSuccess(
      String username, String password, User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username);
    await prefs.setString('password', password);
    await prefs.setString('user', jsonEncode(user.toJson()));
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Welcome back to MedInvent',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: screenHeight * 0.025,
                ),
              ),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              Text(
                'You have to sign in to continue',
                style: TextStyle(
                  fontSize: screenHeight * 0.017,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.25),
                child: Image.asset(
                  'assets/images/login.png',
                ),
              ),
              SizedBox(height: screenHeight * 0.03),
              InputField(
                controller: _email,
                keyboardType: TextInputType.text,
                prefixIcon: const Icon(Icons.person, color: Colors.grey),
                hint: 'Email/Phone No',
                isPassword: false,
              ),
              SizedBox(height: screenHeight * 0.02),
              InputField(
                controller: _password,
                keyboardType: TextInputType.text,
                prefixIcon: const Icon(Icons.lock, color: Colors.grey),
                hint: 'Password',
                isPassword: true,
              ),
              Padding(
                padding: EdgeInsets.only(
                    right: screenWidth * 0.15, top: screenHeight * 0.02),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PasswordReset1()),
                      );
                    },
                    child: Text(
                      'Forgot Password ?',
                      style: TextStyle(fontSize: screenHeight * 0.016),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.05,
              ),
              isLoading
                  ? SpinKitThreeBounce(
                      size: screenWidth * 0.06,
                      color: const Color(0xFF2980B9),
                    )
                  : CustomButton(
                      text: 'Sign In',
                      onPressed: () => loginAuth(context),
                    ),
              SizedBox(height: screenHeight * 0.05),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'New to Medinvent? ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: screenHeight * 0.016),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Register1()),
                      );
                    },
                    child: Text(
                      'Register here',
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
    );
  }
}
