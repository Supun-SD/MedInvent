import 'package:flutter/material.dart';
import 'package:medinvent/presentation/Screens/password_reset/password_reset_1.dart';
import 'package:medinvent/presentation/components/input_field.dart';
import 'package:medinvent/presentation/Screens/Register/register_1.dart';


class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

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
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color(0xFF2980B9),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    minimumSize: const Size(0, 50.0),
                  ),
                  child: const Text(
                    'Sign In',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
              ),
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
