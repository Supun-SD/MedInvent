import 'package:flutter/material.dart';
import 'package:MedInvent/features/login/presentation/pages/password_reset_2.dart';
import 'package:MedInvent/presentation/components/custom_button.dart';
import 'package:MedInvent/presentation/components//input_field.dart';

class PasswordReset1 extends StatelessWidget {
  const PasswordReset1({super.key});

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
                    prefixIcon: Icon(Icons.person),
                    hint: 'Email/Phone No.',
                    isPassword: false),
                const SizedBox(
                  height: 20,
                ),
                const InputField(
                    keyboardType: TextInputType.text,
                    prefixIcon: Icon(Icons.tag),
                    hint: 'NIC',
                    isPassword: false),
                const SizedBox(height: 100),
                CustomButton(
                    text: 'Reset Password',
                    onPressed: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const PasswordReset2()),
                          )
                        }),
              ],
            ),
          ),
        ));
  }
}
