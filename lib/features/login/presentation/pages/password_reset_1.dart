import 'package:flutter/material.dart';
import 'package:MedInvent/features/login/presentation/pages/password_reset_2.dart';
import 'package:MedInvent/presentation/components/custom_button.dart';
import 'package:MedInvent/presentation/components//input_field.dart';

class PasswordReset1 extends StatefulWidget {
  const PasswordReset1({super.key});

  @override
  State<PasswordReset1> createState() => _PasswordReset1State();
}

class _PasswordReset1State extends State<PasswordReset1> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _NIC = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final String userEmail = "123@gmail.com";
  final String userMobile = "0771234567";
  final String userNIC = "123456789";

  Future<void> _credentialsMismatch() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Invalid Credentials'),
          content: const Text(
              'Entered Mobile Number or email address and NIC number doesn\'t match'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
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
                      controller: _email,
                      keyboardType: TextInputType.text,
                      prefixIcon: const Icon(Icons.person),
                      hint: 'Email/Phone No.',
                      isPassword: false),
                  const SizedBox(
                    height: 20,
                  ),
                  InputField(
                      controller: _NIC,
                      keyboardType: TextInputType.text,
                      prefixIcon: const Icon(Icons.tag),
                      hint: 'NIC',
                      isPassword: false),
                  const SizedBox(height: 100),
                  CustomButton(
                      text: 'Reset Password',
                      onPressed: () => {
                            if ((_email.text == userEmail ||
                                    _email.text == userMobile) &&
                                _NIC.text == userNIC)
                              {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const PasswordReset2()),
                                )
                              }
                            else{
                              _credentialsMismatch(),
                              _email.clear(),
                              _NIC.clear(),
                            }
                          }),
                ],
              ),
            ),
          ),
        ));
  }
}
