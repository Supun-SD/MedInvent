import 'package:MedInvent/features/login/presentation/pages/password_reset_3.dart';
import 'package:MedInvent/components/otp_input.dart';
import 'package:MedInvent/providers/authProvider.dart';
import 'package:flutter/material.dart';
import 'package:MedInvent/components/custom_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PasswordReset2 extends ConsumerStatefulWidget {
  const PasswordReset2({super.key});

  @override
  ConsumerState<PasswordReset2> createState() => _PasswordReset2State();
}

class _PasswordReset2State extends ConsumerState<PasswordReset2> {
  final List<TextEditingController> controllers =
      List.generate(4, (index) => TextEditingController());

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  String? _getOtp() {
    for (var controller in controllers) {
      if (controller.text.isEmpty) {
        return null;
      }
    }
    String otp = controllers.map((controller) => controller.text).join();
    return otp;
  }

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
                    'Enter the confirmation code sent to ${ref.watch(userProvider).user!.mobileNo}}',
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
                  child: OTPInput(
                    controllers: controllers,
                  ),
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
                                builder: (context) => const PasswordReset3()),
                          )
                        }),
              ],
            ),
          ),
        ));
  }
}
