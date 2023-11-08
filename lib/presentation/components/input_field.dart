import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final Icon? prefixIcon;
  final String hint;
  final bool isPassword;

  const InputField({
    Key? key,
    this.prefixIcon,
    required this.hint,
    required this.isPassword,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: TextField(
        obscureText: isPassword,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          prefixIcon: prefixIcon != null
              ? Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 5),
                  child: prefixIcon,
                )
              : null,
          hintText: hint,
          contentPadding: const EdgeInsets.symmetric(horizontal: 25,vertical: 20),
        ),
      ),
    );
  }
}

