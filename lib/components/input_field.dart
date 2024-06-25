import 'package:flutter/material.dart';

class InputField extends StatefulWidget {
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
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.12),
      child: TextFormField(
        validator: widget.validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        obscureText: _obscureText,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(screenWidth * 0.1),
            borderSide: const BorderSide(color: Colors.blue),
          ),
          prefixIcon: widget.prefixIcon != null
              ? Padding(
                  padding: EdgeInsets.fromLTRB(
                      screenWidth * 0.025, 0, 0, screenHeight * 0.005),
                  child: widget.prefixIcon,
                )
              : null,
          suffixIcon: widget.isPassword
              ? Padding(
                  padding: EdgeInsets.only(right: screenWidth * 0.025),
                  child: IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                      color: Colors.grey[400],
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                )
              : null,
          hintText: widget.hint,
          contentPadding: EdgeInsets.symmetric(
              vertical: screenHeight * 0.022, horizontal: screenWidth * 0.055),
        ),
      ),
    );
  }
}
