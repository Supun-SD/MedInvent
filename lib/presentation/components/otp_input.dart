import 'package:flutter/material.dart';

class OTPInput extends StatelessWidget {
  const OTPInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          height: 60,
          width: 60,
          child: TextFormField(
            autofocus: true,
            keyboardType: TextInputType.number,
            maxLength: 1,
            decoration: const InputDecoration(counterText: ""),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge,
            onSaved: (pin1) {},
            onChanged: (value) {
              if (value.length == 1) {
                FocusScope.of(context).nextFocus();
              }
            },
          ),
        ),
        SizedBox(
          height: 60,
          width: 60,
          child: TextFormField(
            autofocus: true,
            keyboardType: TextInputType.number,
            maxLength: 1,
            decoration: const InputDecoration(counterText: ""),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge,
            onSaved: (pin2) {},
            onChanged: (value) {
              if (value.length == 1) {
                FocusScope.of(context).nextFocus();
              }
            },
          ),
        ),
        SizedBox(
          height: 60,
          width: 60,
          child: TextFormField(
            autofocus: true,
            keyboardType: TextInputType.number,
            maxLength: 1,
            decoration: const InputDecoration(counterText: ""),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge,
            onSaved: (pin3) {},
            onChanged: (value) {
              if (value.length == 1) {
                FocusScope.of(context).nextFocus();
              }
            },
          ),
        ),
        SizedBox(
          height: 60,
          width: 60,
          child: TextFormField(
            autofocus: true,
            keyboardType: TextInputType.number,
            maxLength: 1,
            decoration: const InputDecoration(counterText: ""),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge,
            onSaved: (pin4) {},
            onChanged: (value) {
              if (value.length == 1) {
                FocusScope.of(context).nextFocus();
              }
            },
          ),
        ),
      ],
    ));
  }
}
