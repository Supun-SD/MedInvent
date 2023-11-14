import 'package:flutter/material.dart';
import 'package:MedInvent/features/login/presentation/pages/password_reset_1.dart';
import 'package:MedInvent/presentation/components/input_field.dart';
import 'package:MedInvent/features/Register/presentation/pages/register_1.dart';
import 'package:MedInvent/features/home/presentation/home.dart';
import 'package:MedInvent/presentation/components/custom_button.dart';

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
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Welcome back to MedInvent',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'You have to sign in to continue',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(100, 50, 100, 20),
                child: Image.asset(
                  'assets/images/login.jpg',
                ),
              ),
              const SizedBox(height: 20),
              InputField(
                controller: _emailTEC,
                keyboardType: TextInputType.text,
                prefixIcon: const Icon(Icons.person, color: Colors.grey),
                hint: 'Email/Phone No',
                isPassword: false,
              ),
              const SizedBox(height: 15),
              InputField(
                controller: _passwordTEC,
                keyboardType: TextInputType.text,
                prefixIcon: const Icon(Icons.lock, color: Colors.grey),
                hint: 'Password',
                isPassword: true,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 60.0, top: 10),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PasswordReset1()),
                      );
                    },
                    child: const Text(
                      'Forgot Password ?',
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              CustomButton(
                  text: 'Sign In',
                  onPressed: () => {
                        if (_emailTEC.text == username &&
                            _passwordTEC.text == password)
                          {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomePage()),
                            )
                          }
                        else
                          {
                            _invalidCredentials(),
                            _emailTEC.clear(),
                            _passwordTEC.clear()
                          }
                      }),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'New to Medinvent? ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Register1()),
                      );
                    },
                    child: const Text(
                      'Register here',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
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
