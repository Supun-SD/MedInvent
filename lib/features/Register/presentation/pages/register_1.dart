import 'package:MedInvent/presentation/components/custom_button.dart';
import 'package:MedInvent/presentation/components/input_field.dart';
import 'package:flutter/material.dart';
import 'package:MedInvent/features/login/presentation/pages/login.dart';
import 'package:MedInvent/features/Register/presentation/pages/register_2.dart';
import '../validations.dart';

class Register1 extends StatefulWidget {
  const Register1({super.key});

  @override
  State<Register1> createState() => _Register1State();
}

class _Register1State extends State<Register1> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _mobileNo = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  "Welcome to MedInvent",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Please register to continue",
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(
                  height: 85,
                ),
                InputField(
                    validator: validateEmail,
                    controller: _email,
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: const Icon(Icons.email_outlined),
                    hint: 'Email',
                    isPassword: false),
                const SizedBox(
                  height: 20,
                ),
                InputField(
                    validator: validateMobileNo,
                    controller: _mobileNo,
                    keyboardType: TextInputType.number,
                    prefixIcon: const Icon(Icons.phone),
                    hint: 'Mobile No.',
                    isPassword: false),
                const SizedBox(
                  height: 20,
                ),
                InputField(
                    validator: (value) => validatePassword(value),
                    controller: _password,
                    keyboardType: TextInputType.text,
                    prefixIcon: const Icon(Icons.lock_open),
                    hint: 'Password',
                    isPassword: true),
                const SizedBox(
                  height: 20,
                ),
                InputField(
                    validator: (value) => confirmPassword(value, _password.text),
                    controller: _confirmPassword,
                    keyboardType: TextInputType.text,
                    prefixIcon: const Icon(Icons.lock_open),
                    hint: 'Confirm Password',
                    isPassword: true),
                const SizedBox(
                  height: 70,
                ),
                CustomButton(
                  text: 'Next',
                  onPressed: () {
                    if (_formKey.currentState?.validate() == true) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Register2()),
                      );
                    }
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account? ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()),
                        );
                      },
                      child: const Text(
                        'Sign in',
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
      ),
    );
  }
}
