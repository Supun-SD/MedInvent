import 'package:MedInvent/config/api.dart';
import 'package:MedInvent/features/Register/data/models/user_model.dart';
import 'package:MedInvent/features/Register/presentation/pages/register_3.dart';
import 'package:MedInvent/features/Register/presentation/validations.dart';
import 'package:MedInvent/components/custom_button.dart';
import 'package:MedInvent/components//input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Register2 extends StatefulWidget {
  final User user;
  const Register2({Key? key, required this.user}) : super(key: key);

  @override
  Register2State createState() => Register2State();
}

class Register2State extends State<Register2> {
  final List<String> genderOptions = ['Male', 'Female', 'Prefer not to say'];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _fName = TextEditingController();
  final TextEditingController _lName = TextEditingController();
  final TextEditingController _nic = TextEditingController();

  bool isLoading = false;

  //function to dispose controllers when not in use
  @override
  void dispose() {
    _fName.dispose();
    _lName.dispose();
    _nic.dispose();
    super.dispose();
  }

  String selectedGender = 'Male';
  DateTime selectedDate = DateTime.now();

  Future<bool> checkNic() async {
    String apiUrl = '${ApiConfig.baseUrl}/patientuser/check/nic/${_nic.text}';

    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);

        if (jsonResponse['data']['message'] == "Patient not found") {
          return true;
        } else {
          _showErrorDialog("This NIC number is already used");
        }
      } else {
        _showErrorDialog("Failed to check availability");
      }
    } catch (e) {
      _showErrorDialog("Error: $e");
      return false;
    } finally {
      setState(() {
        isLoading = false;
      });
    }
    return false;
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text('Registration Failed'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

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
                    controller: _nic,
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
                if (isLoading)
                  SpinKitThreeBounce(
                    size: screenWidth * 0.06,
                    color: const Color(0xFF2980B9),
                  )
                else
                  CustomButton(
                    text: 'Next',
                    onPressed: () async {
                      if (_formKey.currentState?.validate() == true) {
                        bool isAvailable = await checkNic();

                        if (mounted) {
                          if (isAvailable) {
                            widget.user.fName = _fName.text;
                            widget.user.lName = _lName.text;
                            widget.user.nic = _nic.text;
                            widget.user.dob =
                                selectedDate.toString().split(" ")[0];
                            widget.user.gender = selectedGender;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Register3(user: widget.user)),
                            );
                          }
                        }
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
