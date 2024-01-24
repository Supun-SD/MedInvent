import 'package:MedInvent/features/login/presentation/pages/password_reset_3.dart';
import 'package:MedInvent/components/otp_input.dart';
import 'package:flutter/material.dart';
import 'package:MedInvent/components/custom_button.dart';

class PasswordReset2 extends StatelessWidget {
  const PasswordReset2({super.key});

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
              children: [
                Text(
                  'Reset your password',
                  style: TextStyle(
                    fontSize: screenHeight * 0.025,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.25,
                      vertical: screenHeight * 0.05),
                  child: Image.asset('assets/images/pwreset.jpg'),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                  child: Text(
                    'Enter the confirmation code sent to +94771234567',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: screenHeight * 0.02,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.15,
                      vertical: screenHeight * 0.05),
                  child: OTPInput(),
                ),
                const SizedBox(
                  height: 50,
                ),
                CustomButton(
                    text: 'Submit',
                    onPressed: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PasswordReset3()),
                          )
                        }),
              ],
            ),
          ),
        ));
  }
}
