import 'package:MedInvent/presentation/Screens/password_reset/password_reset_3.dart';
import 'package:MedInvent/presentation/components/otp_input.dart';
import 'package:flutter/material.dart';
import 'package:MedInvent/presentation/components/custom_button.dart';

class PasswordReset2 extends StatelessWidget {
  const PasswordReset2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Reset your password',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(100, 50, 100, 30),
                  child: Image.asset('assets/images/pwreset.jpg'),
                ),
                const Text(
                  'Enter the confirmation code sent to +94771234567',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 30),
                    child: OTPInput(),
                ),
                const SizedBox(height: 50,),
                CustomButton(text: 'Submit', onPressed: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PasswordReset3()),
                  )
                }),
              ],
            ),
          ),
        ));
  }
}
