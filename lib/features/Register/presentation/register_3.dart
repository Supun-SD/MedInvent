import 'package:MedInvent/features/Register/models/user_model.dart';
import 'package:MedInvent/features/Register/validations.dart';
import 'package:MedInvent/components/custom_button.dart';
import 'package:MedInvent/components//input_field.dart';
import 'package:MedInvent/providers/authProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../data/districts.dart';

class Register3 extends ConsumerStatefulWidget {
  final NewUser user;
  const Register3({super.key, required this.user});

  @override
  ConsumerState<Register3> createState() => Register3State();
}

class Register3State extends ConsumerState<Register3> {
  final TextEditingController _addressLine1 = TextEditingController();
  final TextEditingController _addressLine2 = TextEditingController();
  final TextEditingController _city = TextEditingController();
  final TextEditingController _postalCode = TextEditingController();

  //function to dispose controllers when not in use
  @override
  void dispose() {
    _addressLine1.dispose();
    _addressLine2.dispose();
    _city.dispose();
    _postalCode.dispose();
    super.dispose();
  }

  void onSubmit() async {
    if (_formKey.currentState?.validate() == false) {
      return;
    }
    widget.user.lineOne = _addressLine1.text;
    widget.user.lineTwo = _addressLine2.text;
    widget.user.city = _city.text;
    widget.user.district = selectedDistrict;
    widget.user.postalCode = _postalCode.text;

    await ref.read(userProvider.notifier).registerUser(widget.user, context);
  }

  String selectedDistrict = "Colombo";

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    bool isLoading = ref.watch(userProvider).isLoading;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Enter your residential address',
                  style: TextStyle(fontSize: screenHeight * 0.02),
                ),
                Text(
                  '(Optional)',
                  style: TextStyle(fontSize: screenHeight * 0.02),
                ),
                SizedBox(height: screenHeight * 0.07),
                InputField(
                    validator: (value) => emptyValidation(value, "Line 1"),
                    controller: _addressLine1,
                    keyboardType: TextInputType.text,
                    hint: 'Line 1',
                    isPassword: false),
                SizedBox(height: screenHeight * 0.02),
                InputField(
                    controller: _addressLine2,
                    keyboardType: TextInputType.text,
                    hint: 'Line 2 (Optional)',
                    isPassword: false),
                SizedBox(height: screenHeight * 0.02),
                InputField(
                    validator: (value) => emptyValidation(value, "City"),
                    controller: _city,
                    keyboardType: TextInputType.text,
                    hint: 'City',
                    isPassword: false),
                SizedBox(height: screenHeight * 0.02),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.12),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(screenWidth * 0.1),
                    ),
                    padding: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.003,
                        horizontal: screenWidth * 0.055),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: selectedDistrict,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedDistrict = newValue ?? 'Male';
                        });
                      },
                      underline: Container(),
                      items: districts.map((String gender) {
                        return DropdownMenuItem<String>(
                          value: gender,
                          child: Text(gender),
                        );
                      }).toList(),
                      elevation: 16,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20.0)),
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                InputField(
                    controller: _postalCode,
                    keyboardType: TextInputType.number,
                    hint: 'Postal Code (Optional)',
                    isPassword: false),
                SizedBox(height: screenHeight * 0.1),
                isLoading
                    ? SpinKitThreeBounce(
                        size: screenWidth * 0.06,
                        color: const Color(0xFF2980B9),
                      )
                    : CustomButton(text: 'Register', onPressed: onSubmit),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
