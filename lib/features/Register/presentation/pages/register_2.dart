import 'package:MedInvent/features/Register/presentation/pages/register_3.dart';
import 'package:MedInvent/presentation/components/custom_button.dart';
import 'package:MedInvent/presentation/components//input_field.dart';
import 'package:flutter/material.dart';

class Register2 extends StatefulWidget {
  const Register2({Key? key}) : super(key: key);

  @override
  Register2State createState() => Register2State();
}

class Register2State extends State<Register2> {

  final List<String> genderOptions = ['Male', 'Female', 'Prefer not to say'];

  String selectedGender = 'Male';

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
                'Please Enter the following information',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 90,),
              const InputField(keyboardType:TextInputType.text,hint: 'First Name', isPassword: false),
              const SizedBox(height: 20,),
              const InputField(keyboardType:TextInputType.text,hint: 'Last Name', isPassword: false),
              const SizedBox(height: 20,),
              const InputField(keyboardType:TextInputType.text,hint: 'NIC', isPassword: false),
              const SizedBox(height: 20,),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 3),
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: selectedGender,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedGender = newValue ?? 'Male';
                      });
                    },
                    items: genderOptions.map((String gender) {
                      return DropdownMenuItem<String>(
                        value: gender,
                        child: Text(gender),
                      );
                    }).toList(),
                  ),
                ),
              ),

              const SizedBox(height: 100,),
              CustomButton(text: 'Next', onPressed: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const Register3()),
                )
              }),
            ],
          ),
        ),
      ),
    );
  }
}

