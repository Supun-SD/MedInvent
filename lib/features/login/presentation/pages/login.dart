import 'package:MedInvent/features/home/presentation/mainPage.dart';
import 'package:flutter/material.dart';
import 'package:MedInvent/features/login/presentation/pages/password_reset_1.dart';
import 'package:MedInvent/components/input_field.dart';
import 'package:MedInvent/features/Register/presentation/pages/register_1.dart';
import 'package:MedInvent/components/custom_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //temporary username ans password
  final String username = "admin";
  final String password = "admin";

  final TextEditingController _emailTEC = TextEditingController();
  final TextEditingController _passwordTEC = TextEditingController();

  //function to dispose controllers when not in use
  @override
  void dispose() {
    _emailTEC.dispose();
    _passwordTEC.dispose();
    super.dispose();
  }

  //pop to show when invalid credentials are entered
  Future<void> _invalidCredentials() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Invalid Credentials'),
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
  void loginAuth() async{
    if (_emailTEC.text == username && _passwordTEC.text == password) {
      await _onLoginSuccess(username,password);
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const Home(
                  sideNavIndex: 2,
                )),
      );
    } else {
      _invalidCredentials();
      _emailTEC.clear();
      _passwordTEC.clear();
    }
  }

  Future<void>_onLoginSuccess(String username ,String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username);
    await prefs.setString('password', password);
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
                controller: _emailTEC,
                keyboardType: TextInputType.text,
                prefixIcon: const Icon(Icons.person, color: Colors.grey),
                hint: 'Email/Phone No',
                isPassword: false,
              ),
              SizedBox(height: screenHeight * 0.02),
              InputField(
                controller: _passwordTEC,
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
              CustomButton(
                text: 'Sign In',
                onPressed: loginAuth,
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
