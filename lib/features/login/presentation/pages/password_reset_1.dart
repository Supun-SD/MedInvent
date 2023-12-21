import 'package:flutter/material.dart';
import 'package:MedInvent/presentation/components/custom_button.dart';
import 'package:MedInvent/presentation/components//input_field.dart';
import 'package:go_router/go_router.dart';

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
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.25, vertical: screenHeight * 0.05),
                    child: Image.asset('assets/images/pwreset.jpg'),
                  ),
                  InputField(
                      controller: _email,
                      keyboardType: TextInputType.text,
                      prefixIcon: const Icon(Icons.person),
                      hint: 'Email/Phone No.',
                      isPassword: false),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  InputField(
                      controller: _NIC,
                      keyboardType: TextInputType.text,
                      prefixIcon: const Icon(Icons.tag),
                      hint: 'NIC',
                      isPassword: false),
                  SizedBox(height: screenHeight * 0.07),
                  CustomButton(
                      text: 'Reset Password',
                      onPressed: () => {
                            if ((_email.text == userEmail ||
                                    _email.text == userMobile) &&
                                _NIC.text == userNIC)
                              {
                                GoRouter.of(context).pushNamed('forgotPassword2')
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
