import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final Icon? prefixIcon;
  final String hint;
  final String? Function(String?)? validator;
  final bool isPassword;
  final TextInputType keyboardType;
  final TextEditingController controller;

  const InputField({
    Key? key,
    this.prefixIcon,
    required this.hint,
    required this.isPassword,
    required this.keyboardType,
    required this.controller,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.12),
      child: TextFormField(
        validator: validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: controller,
        keyboardType: keyboardType,
        obscureText: isPassword,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(screenWidth * 0.1),
            borderSide: const BorderSide(color: Colors.blue),
          ),
          prefixIcon: prefixIcon != null
              ? Padding(
                  padding: EdgeInsets.fromLTRB(screenWidth * 0.025, 0, 0, screenHeight * 0.005),
                  child: prefixIcon,
                )
              : null,
          hintText: hint,
          contentPadding:
              EdgeInsets.symmetric(vertical: screenHeight * 0.022 , horizontal: screenWidth * 0.055 ),
        ),
      ),
    );
  }
}
