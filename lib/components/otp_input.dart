import 'package:flutter/material.dart';

class OTPInput extends StatelessWidget {
  final List<TextEditingController> controllers;

  const OTPInput({Key? key, required this.controllers}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Form(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(controllers.length, (index) {
          return SizedBox(
            height: screenHeight * 0.04,
            width: screenWidth * 0.13,
            child: TextFormField(
              controller: controllers[index],
              autofocus: index == 0,
              keyboardType: TextInputType.number,
              maxLength: 1,
              decoration: const InputDecoration(counterText: ""),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge,
              onChanged: (value) {
                if (value.length == 1) {
                  FocusScope.of(context).nextFocus();
                }
              },
            ),
          );
        }),
      ),
    );
  }
}
