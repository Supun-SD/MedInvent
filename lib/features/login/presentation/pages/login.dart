import 'package:flutter/material.dart';
import 'package:MedInvent/presentation/components/input_field.dart';
import 'package:MedInvent/presentation/components/custom_button.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final String username = "admin";
  final String password = "admin";

  final TextEditingController _emailTEC = TextEditingController();
  final TextEditingController _passwordTEC = TextEditingController();

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
                      GoRouter.of(context).pushNamed('forgotPassword1');
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
                  onPressed: () => {
                        if (_emailTEC.text == username &&
                            _passwordTEC.text == password)
                          {
                            GoRouter.of(context).pushNamed('home')
                          }
                        else
                          {
                            _invalidCredentials(),
                            _emailTEC.clear(),
                            _passwordTEC.clear()
                          }
                      }),
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
                      GoRouter.of(context).pushNamed('register1');
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
