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
                padding: const EdgeInsets.symmetric(horizontal: 100),
                child: Image.asset(
                  'assets/images/login.png',
                ),
              ),
              const SizedBox(height: 20),
              const InputField(
                keyboardType:TextInputType.text,
                prefixIcon: Icon(Icons.person, color: Colors.grey),
                hint: 'Email/Phone No',
                isPassword: false,
              ),
              const SizedBox(height: 15),
              const InputField(
                keyboardType:TextInputType.text,
                prefixIcon: Icon(Icons.lock, color: Colors.grey),
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
                            builder: (context) => const PasswordReset1()),
                      );
                    },
                    child: const Text(
                      'Forgot Password ?',
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 100,),

              CustomButton(text: 'Sign In', onPressed: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const HomePage()),
                )
              }),

              //const SizedBox(height: 20),


              // Container(
              //   width: double.infinity,
              //   padding: const EdgeInsets.symmetric(horizontal: 50.0),
              //   child: TextButton(
              //     onPressed: () {},
              //     style: TextButton.styleFrom(
              //       foregroundColor: Colors.white,
              //       backgroundColor: const Color(0xFF2980B9),
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(30.0),
              //       ),
              //       minimumSize: const Size(0, 50.0),
              //     ),
              //     child: const Text(
              //       'Sign In',
              //       style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              //     ),
              //   ),




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
