import 'package:MedInvent/components/custom_button.dart';
import 'package:MedInvent/components/input_field.dart';
import 'package:flutter/material.dart';
import 'package:MedInvent/features/Register/presentation/pages/register_2.dart';
import '../validations.dart';
import 'package:MedInvent/components/user_data.dart';

class Register1 extends StatefulWidget {
  final UserData u = UserData();
  Register1({super.key});

  @override
  State<Register1> createState() => _Register1State();
}

class _Register1State extends State<Register1> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _mobileNo = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();

  //function to dispose controllers when not in use
  @override
  void dispose() {
    _email.dispose();
    _mobileNo.dispose();
    _password.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Welcome to MedInvent",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: screenHeight * 0.025,
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.01,
                ),
                Text(
                  "Please register to continue",
                  style: TextStyle(
                    fontSize: screenHeight * 0.02,
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.1,
                ),
                InputField(
                    validator: validateEmail,
                    controller: _email,
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: const Icon(Icons.email_outlined),
                    hint: 'Email',
                    isPassword: false),
                SizedBox(height: screenHeight * 0.02),
                InputField(
                    validator: validateMobileNo,
                    controller: _mobileNo,
                    keyboardType: TextInputType.number,
                    prefixIcon: const Icon(Icons.phone),
                    hint: 'Mobile No.',
                    isPassword: false),
                SizedBox(height: screenHeight * 0.02),
                InputField(
                    validator: (value) => validatePassword(value),
                    controller: _password,
                    keyboardType: TextInputType.text,
                    prefixIcon: const Icon(Icons.lock_open),
                    hint: 'Password',
                    isPassword: true),
                SizedBox(height: screenHeight * 0.02),
                InputField(
                    validator: (value) =>
                        confirmPassword(value, _password.text),
                    controller: _confirmPassword,
                    keyboardType: TextInputType.text,
                    prefixIcon: const Icon(Icons.lock_open),
                    hint: 'Confirm Password',
                    isPassword: true),
                SizedBox(height: screenHeight * 0.08),
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Colors.blue),
                    ),
                  ),
                ),
                CustomButton(
                  text: 'Next',
                  onPressed: () {
                    if (_formKey.currentState?.validate() == true) {
                      widget.u.email = _email.text;
                      widget.u.mobileNumber =
                          int.parse("94${_mobileNo.text.substring(1)}");
                      widget.u.password = _password.text;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                Register2(userData: widget.u)),
                      );
                    }
                  },
                ),
                SizedBox(height: screenHeight * 0.04),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: screenHeight * 0.016),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Sign in',
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: screenHeight * 0.016),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
