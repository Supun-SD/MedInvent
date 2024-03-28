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

  //function to dispose controllers when not in use
  @override
  void dispose() {
    _fName.dispose();
    _lName.dispose();
    _NIC.dispose();
    super.dispose();
  }

  String selectedGender = 'Male';
  DateTime selectedDate = DateTime.now();


  //pop up to select the birthdate
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

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
                    validator: (value) => nameValidation(value!, "First Name"),
                    controller: _fName,
                    keyboardType: TextInputType.text,
                    hint: 'First Name',
                    isPassword: false),
                SizedBox(height: screenHeight * 0.02),
                InputField(
                    validator: (value) => nameValidation(value!, "Last Name"),
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
                Container(
                  margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.12),
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.055,
                      vertical: screenHeight * 0.005),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        "${selectedDate.toLocal()}".split(' ')[0],
                        style: TextStyle(fontSize: screenWidth * 0.038),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () => _selectDate(context),
                        icon: const Icon(
                          Icons.calendar_month,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
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
                      underline: Container(),
                      items: genderOptions.map((String gender) {
                        return DropdownMenuItem<String>(
                          value: gender,
                          child: Text(gender),
                        );
                      }).toList(),
                      elevation: 16,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20.0)),
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.1),
                CustomButton(
                  text: 'Next',
                  onPressed: () {
                    if (_formKey.currentState?.validate() == true) {
                      widget.userData.firstName = _fName.text;
                      widget.userData.lastName = _lName.text;
                      widget.userData.nic = _NIC.text;
                      widget.userData.birthDate = selectedDate;
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
