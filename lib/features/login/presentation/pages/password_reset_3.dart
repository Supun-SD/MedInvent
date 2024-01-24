import 'package:MedInvent/features/Register/presentation/validations.dart';
import 'package:MedInvent/features/login/presentation/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:MedInvent/components/custom_button.dart';
import 'package:MedInvent/components//input_field.dart';

class PasswordReset3 extends StatefulWidget {
  const PasswordReset3({super.key});

  @override
  State<PasswordReset3> createState() => _PasswordReset3State();
}

class _PasswordReset3State extends State<PasswordReset3> {
  final TextEditingController _newPassword = TextEditingController();

  final TextEditingController _newPasswordConfirm = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _passwordReset() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Password reset Successful'),
          content: const Text('Your password has been updated successfully!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
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
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
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
                  InputField(
                      validator: (value) => validatePassword(value),
                      controller: _newPassword,
                      keyboardType: TextInputType.text,
                      prefixIcon: const Icon(Icons.key),
                      hint: 'New Password',
                      isPassword: true),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  InputField(
                      validator: (value) =>
                          confirmPassword(value, _newPassword.text),
                      controller: _newPasswordConfirm,
                      keyboardType: TextInputType.text,
                      prefixIcon: const Icon(Icons.key),
                      hint: 'Confirm new password',
                      isPassword: true),
                  SizedBox(height: screenHeight * 0.07),
                  CustomButton(
                      text: 'Reset Password',
                      onPressed: () => {
                            if (_formKey.currentState?.validate() == true)
                              {_passwordReset()}
                          }),
                ],
              ),
            ),
          ),
        ));
  }
}
