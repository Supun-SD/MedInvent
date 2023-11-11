import 'package:medinvent/presentation/Screens/Register/register_4.dart';
import 'package:medinvent/presentation/components/custom_button.dart';
import 'package:medinvent/presentation/components//input_field.dart';
import 'package:flutter/material.dart';

class Register3 extends StatelessWidget {
  const Register3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
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
              const InputField(
                  keyboardType: TextInputType.text,
                  hint: 'Line 1',
                  isPassword: false),
              const SizedBox(
                height: 20,
              ),
              const InputField(
                  keyboardType: TextInputType.text,
                  hint: 'Line 2',
                  isPassword: false),
              const SizedBox(
                height: 20,
              ),
              const InputField(
                  keyboardType: TextInputType.text,
                  hint: 'City',
                  isPassword: false),
              const SizedBox(
                height: 20,
              ),
              const InputField(
                  keyboardType: TextInputType.text,
                  hint: 'District',
                  isPassword: false),
              const SizedBox(
                height: 20,
              ),
              const InputField(
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
                  onPressed: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Register4()),
                        )
                      }),
            ],
          ),
        ),
      ),
    );
  }
}
