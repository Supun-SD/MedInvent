import 'package:flutter/material.dart';
import 'package:MedInvent/presentation/components/custom_button.dart';
import 'package:MedInvent/presentation/components//input_field.dart';
import 'package:MedInvent/features/login/presentation/pages/login.dart';

class Register4 extends StatelessWidget {
  const Register4({super.key});

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
                'Enter your demographic details',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 90,),
              const InputField(keyboardType:TextInputType.datetime,hint: 'Date of Birth', isPassword: false),
              const SizedBox(height: 20,),
              const InputField(keyboardType:TextInputType.number,hint: 'Height (cm)', isPassword: false),
              const SizedBox(height: 20,),
              const InputField(keyboardType:TextInputType.number,hint: 'Weight (Kg)', isPassword: false),
              const SizedBox(height: 20,),

              const SizedBox(height: 100,),
              CustomButton(text: 'Register', onPressed: () => {Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const LoginPage()),
              )}),
            ],
          ),
        ),
      ),
    );
  }
}

