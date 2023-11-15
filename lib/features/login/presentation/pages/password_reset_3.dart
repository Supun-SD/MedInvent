import 'package:MedInvent/features/Register/presentation/validations.dart';
import 'package:MedInvent/features/login/presentation/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:MedInvent/presentation/components/custom_button.dart';
import 'package:MedInvent/presentation/components//input_field.dart';

class PasswordReset3 extends StatefulWidget {
  PasswordReset3({super.key});

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
                  InputField(
                      validator: (value) => validatePassword(value),
                      controller: _newPassword,
                      keyboardType: TextInputType.text,
                      prefixIcon: const Icon(Icons.key),
                      hint: 'New Password',
                      isPassword: true),
                  const SizedBox(
                    height: 20,
                  ),
                  InputField(
                      validator: (value) =>
                          confirmPassword(value, _newPassword.text),
                      controller: _newPasswordConfirm,
                      keyboardType: TextInputType.text,
                      prefixIcon: const Icon(Icons.key),
                      hint: 'Confirm new password',
                      isPassword: true),
                  const SizedBox(height: 50),
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
