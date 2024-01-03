import 'package:MedInvent/components/user_data.dart';
import 'package:MedInvent/features/Register/presentation/pages/register_3.dart';
import 'package:MedInvent/features/Register/presentation/validations.dart';
import 'package:MedInvent/components/custom_button.dart';
import 'package:MedInvent/components//input_field.dart';
import 'package:flutter/material.dart';

class Register2 extends StatefulWidget {
  final UserData userData;
  const Register2({Key? key, required this.userData}) : super(key: key);

  @override
  Register2State createState() => Register2State();
}

class Register2State extends State<Register2> {
  final List<String> genderOptions = ['Male', 'Female', 'Prefer not to say'];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _fName = TextEditingController();
  final TextEditingController _lName = TextEditingController();
  final TextEditingController _NIC = TextEditingController();
  final TextEditingController _dob = TextEditingController();

  String selectedGender = 'Male';

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.12),
                  child: Text(
                    'Please Enter the following information',
                    style: TextStyle(fontSize: screenHeight * 0.02),
                  ),
                ),
                SizedBox(height: screenHeight * 0.1),
                InputField(
                    validator: (value) => emptyValidation(value, "First Name"),
                    controller: _fName,
                    keyboardType: TextInputType.text,
                    hint: 'First Name',
                    isPassword: false),
                SizedBox(height: screenHeight * 0.02),
                InputField(
                    validator: (value) => emptyValidation(value, "Last Name"),
                    controller: _lName,
                    keyboardType: TextInputType.text,
                    hint: 'Last Name',
                    isPassword: false),
                SizedBox(height: screenHeight * 0.02),
                InputField(
                    validator: (value) => emptyValidation(value, "NIC"),
                    controller: _NIC,
                    keyboardType: TextInputType.text,
                    hint: 'NIC',
                    isPassword: false),
                SizedBox(height: screenHeight * 0.02),
                InputField(
                    validator: (value) => dobValidation(value),
                    controller: _dob,
                    keyboardType: TextInputType.datetime,
                    hint: 'Date of Birth (YYYY-MM-DD)',
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
                SizedBox(height: screenHeight * 0.1),
                CustomButton(
                  text: 'Next',
                  onPressed: () {
                    if (_formKey.currentState?.validate() == true) {
                      widget.userData.first_name = _fName.text;
                      widget.userData.last_name = _lName.text;
                      widget.userData.nic = _NIC.text;
                      widget.userData.birth_date = _dob.text;
                      widget.userData.gender = selectedGender;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                Register3(userData: widget.userData)),
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
