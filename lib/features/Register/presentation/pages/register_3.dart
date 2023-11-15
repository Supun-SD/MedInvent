import 'package:MedInvent/features/Register/presentation/pages/register_4.dart';
import 'package:MedInvent/features/Register/presentation/validations.dart';
import 'package:MedInvent/presentation/components/custom_button.dart';
import 'package:MedInvent/presentation/components//input_field.dart';
import 'package:flutter/material.dart';

class Register3 extends StatefulWidget {
  const Register3({super.key});

  @override
  State<Register3> createState() => _Register3State();
}

class _Register3State extends State<Register3> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _addressLine1 = TextEditingController();
  final TextEditingController _addressLine2 = TextEditingController();
  final TextEditingController _city = TextEditingController();
  final TextEditingController _district = TextEditingController();
  final TextEditingController _postalCode = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Enter your residential address',
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(
                  height: 90,
                ),
                InputField(
                    validator: (value) => emptyValidation(value, "Line 1"),
                    controller: _addressLine1,
                    keyboardType: TextInputType.text,
                    hint: 'Line 1',
                    isPassword: false),
                const SizedBox(
                  height: 20,
                ),
                InputField(
                    controller: _addressLine2,
                    keyboardType: TextInputType.text,
                    hint: 'Line 2 (Optional)',
                    isPassword: false),
                const SizedBox(
                  height: 20,
                ),
                InputField(
                    validator: (value) => emptyValidation(value, "City"),
                    controller: _city,
                    keyboardType: TextInputType.text,
                    hint: 'City',
                    isPassword: false),
                const SizedBox(
                  height: 20,
                ),
                InputField(
                    validator: (value) => emptyValidation(value, "District"),
                    controller: _district,
                    keyboardType: TextInputType.text,
                    hint: 'District',
                    isPassword: false),
                const SizedBox(
                  height: 20,
                ),
                InputField(
                    controller: _postalCode,
                    keyboardType: TextInputType.number,
                    hint: 'Postal Code',
                    isPassword: false),
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  height: 50,
                ),
                CustomButton(
                  text: 'Next',
                  onPressed: () {
                    if (_formKey.currentState?.validate() == true) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Register4()),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
