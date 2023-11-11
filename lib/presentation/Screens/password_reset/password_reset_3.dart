import 'package:flutter/material.dart';
import 'package:medinvent/presentation/components/custom_button.dart';
import 'package:medinvent/presentation/components//input_field.dart';

class PasswordReset3 extends StatelessWidget {
  const PasswordReset3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text(
                  'Reset your password',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(100, 50, 100, 50),
                  child: Image.asset('assets/images/pwreset.jpg'),
                ),
                const InputField(
                    keyboardType: TextInputType.text,
                    prefixIcon: Icon(Icons.key),
                    hint: 'New Password',
                    isPassword: true),
                const SizedBox(
                  height: 20,
                ),
                const InputField(
                    keyboardType: TextInputType.text,
                    prefixIcon: Icon(Icons.key),
                    hint: 'Confirm new password',
                    isPassword: true),
                const SizedBox(height: 50),
                CustomButton(text: 'Reset Password', onPressed: () => {}),
              ],
            ),
          ),
        ));
  }
}
