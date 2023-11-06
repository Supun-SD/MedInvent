import 'package:first_app/presentation/widgets/custom_button.dart';
import 'package:first_app/presentation/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:first_app/presentation/pages/login.dart';

class Register1 extends StatelessWidget {
  const Register1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Welcome to MedInvent",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10,),
            const Text(
              "Please register to continue",
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 85,),
            const InputField(prefixIcon: Icon(Icons.email_outlined), hint: 'Email', isPassword: false),
            const SizedBox(height: 20,),
            const InputField(prefixIcon: Icon(Icons.phone), hint: 'Mobile No.', isPassword: false),
            const SizedBox(height: 20,),
            const InputField(prefixIcon: Icon(Icons.lock_open), hint: 'Password', isPassword: true),
            const SizedBox(height: 20,),
            const InputField(prefixIcon: Icon(Icons.lock_open), hint: 'Confirm Password', isPassword: true),
            const SizedBox(height: 70,),
            const CustomButton(text: 'Next'),
            const SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                    "Already have an account? ",
                style: TextStyle(fontWeight: FontWeight.bold),),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginPage()),
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
    );
  }
}
