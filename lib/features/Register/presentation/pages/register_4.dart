import 'package:flutter/material.dart';
import 'package:MedInvent/presentation/components/custom_button.dart';
import 'package:MedInvent/presentation/components//input_field.dart';
import 'package:MedInvent/features/login/presentation/pages/login.dart';
import 'package:MedInvent/features/Register/presentation/validations.dart';

class Register4 extends StatefulWidget {
  const Register4({super.key});

  @override
  State<Register4> createState() => _Register4State();
}

class _Register4State extends State<Register4> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _dob = TextEditingController();
  final TextEditingController _height = TextEditingController();
  final TextEditingController _weight = TextEditingController();

  void _registrationSuccess() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Registration Successful'),
          content: const Text('You have successfully registered!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // close the dialog
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
              children: [
                const Text(
                  'Enter your demographic details',
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(
                  height: 90,
                ),
                InputField(
                    validator: (value) => dobValidation(value),
                    controller: _dob,
                    keyboardType: TextInputType.datetime,
                    hint: 'Date of Birth (YYYY-MM-DD)',
                    isPassword: false),
                const SizedBox(
                  height: 20,
                ),
                InputField(
                    controller: _height,
                    keyboardType: TextInputType.number,
                    hint: 'Height (cm)',
                    isPassword: false),
                const SizedBox(
                  height: 20,
                ),
                InputField(
                    controller: _weight,
                    keyboardType: TextInputType.number,
                    hint: 'Weight (Kg)',
                    isPassword: false),
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  height: 100,
                ),
                CustomButton(
                  text: 'Register',
                  onPressed: () {
                    if (_formKey.currentState?.validate() == true) {
                      _registrationSuccess();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


