import 'package:MedInvent/components/PatientDetailInput.dart';
import 'package:MedInvent/components/RadioButtonOption.dart';
import 'package:MedInvent/components/UserDetail.dart';
import 'package:MedInvent/config/api.dart';
import 'package:MedInvent/features/Search/presentation/appointmentSuccess.dart';
import 'package:MedInvent/features/Search/models/appointment.dart';
import 'package:MedInvent/features/login/data/models/user_model.dart';
import 'package:MedInvent/providers/authProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AppointmentConfirmation extends ConsumerStatefulWidget {
  const AppointmentConfirmation(
      {required this.appointment, required this.doctor, super.key});
  final Appointment appointment;
  final String doctor;

  @override
  ConsumerState<AppointmentConfirmation> createState() =>
      _AppointmentConfirmationState();
}

class _AppointmentConfirmationState
    extends ConsumerState<AppointmentConfirmation> {
  
  List<String> titles = ["Mr", "Ms", "Mrs"];
  String selectedTitle = "Mr";

  String sessionId = "caf60946-c47b-4686-9f2f-ed373f21a68c";

  String _selectedOption = 'Other';

  int doctorFee = 2300;
  int clinicFee = 1000;
  int eChanneling = 600;
  int discount = 200;
  int refundableFee = 250;
  bool isRefundable = false;

  bool isLoading = false;

  final TextEditingController _patientName = TextEditingController();
  final TextEditingController _mobileNo = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _area = TextEditingController();
  final TextEditingController _nic = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _patientName.dispose();
    _mobileNo.dispose();
    _email.dispose();
    _area.dispose();
    _nic.dispose();
    super.dispose();
  }

  bool _validateEmail(String? value) {
    const emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    final regex = RegExp(emailPattern);
    if (value == null || !regex.hasMatch(value)) {
      return false;
    }
    return true;
  }

  bool _validateMobile(String? value) {
    const mobilePattern = r'^07[0-9]{8}$';
    final regex = RegExp(mobilePattern);
    if (value == null || !regex.hasMatch(value)) {
      return false;
    }
    return true;
  }

  String convertMobileNumber(String number) {
    return '+94${number.substring(1)}';
  }

  Future<void> _submitAppointment(User user) async {
    if ((_patientName.text == "" ||
            _mobileNo.text == "" ||
            _email.text == "" ||
            _area.text == "" ||
            _nic.text == "") &&
        _selectedOption == 'Other') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Fields cannot be empty'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    if (!_validateEmail(_email.text) && _selectedOption == 'Other') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Enter a valid email address'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    if (!_validateMobile(_mobileNo.text) && _selectedOption == 'Other') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Enter a valid mobile number'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    String apiUrl = '${ApiConfig.baseUrl}/appointment/newappointment';
    try {
      final response = await http.post(Uri.parse(apiUrl),
          headers: {
            'Content-Type': 'application/json',
          },
          body: json.encode({
            'user_id': user.userId,
            'session_id': sessionId,
            'patientTitle': selectedTitle,
            'patientName': _selectedOption == 'Other'
                ? _patientName.text
                : '${user.fname} ${user.lname}',
            'contactNo': _selectedOption == 'Other'
                ? convertMobileNumber(_mobileNo.text)
                : user.mobileNo,
            'email': _selectedOption == 'Other' ? _email.text : user.email,
            'area': _selectedOption == 'Other'
                ? _area.text
                : user.patientAddress.city,
            'nic': _selectedOption == 'Other' ? _nic.text : user.nic,
          }));

      if (response.statusCode == 200) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const AppointmentSuccess()),
        );
      } else {
        throw Exception('Failed booking appointment');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed booking the appointment.'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    User user = ref.watch(userProvider)!;

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      blurRadius: 20,
                    ),
                  ],
                ),
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.05,
                    vertical: screenHeight * 0.035),
                margin: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.05,
                    vertical: screenHeight * 0.03),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Appointment details",
                      style: TextStyle(
                          fontSize: screenWidth * 0.04,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text("Doctor's name",
                        style: TextStyle(fontSize: screenWidth * 0.03)),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      widget.doctor,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: screenWidth * 0.035),
                    ),
                    const Divider(
                      color: Colors.grey,
                    ),
                    Text("Clinic",
                        style: TextStyle(fontSize: screenWidth * 0.03)),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(widget.appointment.clinic,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: screenWidth * 0.035)),
                    const Divider(
                      color: Colors.grey,
                    ),
                    Text("Date and time",
                        style: TextStyle(fontSize: screenWidth * 0.03)),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text(widget.appointment.date,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: screenWidth * 0.035)),
                        const Spacer(),
                        Text(widget.appointment.time,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: screenWidth * 0.035)),
                      ],
                    ),
                    const Divider(
                      color: Colors.grey,
                    ),
                    Text("Appointment No.",
                        style: TextStyle(fontSize: screenWidth * 0.03)),
                    const SizedBox(
                      height: 5,
                    ),
                    Text((widget.appointment.activePatients + 1).toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: screenWidth * 0.04)),
                    const Divider(
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      blurRadius: 20,
                    ),
                  ],
                ),
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.05,
                    vertical: screenHeight * 0.035),
                margin: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.05,
                ),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Patient's details",
                      style: TextStyle(
                          fontSize: screenWidth * 0.04,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RadioButtonOption(
                          text: 'For me',
                          groupValue: _selectedOption,
                          value: 'For me',
                          onChanged: (value) {
                            setState(() {
                              _selectedOption = value!;
                            });
                          },
                        ),
                        const SizedBox(width: 16),
                        RadioButtonOption(
                          text: 'Other',
                          groupValue: _selectedOption,
                          value: 'Other',
                          onChanged: (value) {
                            setState(() {
                              _selectedOption = value!;
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Title",
                              style: TextStyle(fontSize: screenWidth * 0.035),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              height: 35,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: DropdownButton<String>(
                                items: titles
                                    .map((String item) =>
                                        DropdownMenuItem<String>(
                                          value: item,
                                          child: Text(item),
                                        ))
                                    .toList(),
                                underline: const SizedBox(),
                                icon: const Icon(Icons.arrow_drop_down,
                                    color: Colors.grey),
                                style: const TextStyle(color: Colors.black),
                                dropdownColor: Colors.grey[200],
                                borderRadius: BorderRadius.circular(20.0),
                                value: selectedTitle,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedTitle = newValue!;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 7,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Patient's name",
                                style: TextStyle(fontSize: screenWidth * 0.035),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              if (_selectedOption == 'For me')
                                UserDetail(text: '${user.fname} ${user.lname}')
                              else
                                PatientDetailInput(controller: _patientName)
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Mobile Number",
                      style: TextStyle(fontSize: screenWidth * 0.035),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    if (_selectedOption == 'For me')
                      UserDetail(text: user.mobileNo)
                    else
                      PatientDetailInput(controller: _mobileNo),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Email address",
                      style: TextStyle(fontSize: screenWidth * 0.035),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    if (_selectedOption == 'For me')
                      UserDetail(text: user.email)
                    else
                      PatientDetailInput(controller: _email),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Area",
                                style: TextStyle(fontSize: screenWidth * 0.035),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              if (_selectedOption == 'For me')
                                UserDetail(text: user.patientAddress.city)
                              else
                                PatientDetailInput(controller: _area),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 7,
                        ),
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "NIC",
                              style: TextStyle(fontSize: screenWidth * 0.035),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            if (_selectedOption == 'For me')
                              UserDetail(text: user.nic)
                            else
                              PatientDetailInput(controller: _nic)
                          ],
                        ))
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: isRefundable,
                          onChanged: (bool? value) {
                            setState(() {
                              isRefundable = value!;
                            });
                          },
                        ),
                        const SizedBox(
                          width: 7,
                        ),
                        Expanded(
                            child: Text(
                          "Refundable appointment (Rs.250 will be charged extra.",
                          style: TextStyle(fontSize: screenWidth * 0.03),
                        ))
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      blurRadius: 20,
                    ),
                  ],
                ),
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.05,
                    vertical: screenHeight * 0.035),
                margin: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.05,
                    vertical: screenHeight * 0.03),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Payment details",
                      style: TextStyle(
                          fontSize: screenWidth * 0.04,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: screenWidth * 0.4,
                          child: Text(
                            "Doctor fee",
                            style: TextStyle(fontSize: screenWidth * 0.035),
                          ),
                        ),
                        Text(
                          "Rs. $doctorFee",
                          style: TextStyle(
                              fontSize: screenWidth * 0.035,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: screenWidth * 0.4,
                          child: Text(
                            "Clinic fee",
                            style: TextStyle(fontSize: screenWidth * 0.035),
                          ),
                        ),
                        Text(
                          "Rs. $clinicFee",
                          style: TextStyle(
                              fontSize: screenWidth * 0.035,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: screenWidth * 0.4,
                          child: Text(
                            "e-Channeling fee",
                            style: TextStyle(fontSize: screenWidth * 0.035),
                          ),
                        ),
                        Text(
                          "Rs. $eChanneling",
                          style: TextStyle(
                              fontSize: screenWidth * 0.035,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    if (isRefundable)
                      Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: screenWidth * 0.4,
                                child: Text(
                                  "Refundable fee",
                                  style:
                                      TextStyle(fontSize: screenWidth * 0.035),
                                ),
                              ),
                              Text(
                                "Rs. $refundableFee",
                                style: TextStyle(
                                    fontSize: screenWidth * 0.035,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    Row(
                      children: [
                        SizedBox(
                          width: screenWidth * 0.4,
                          child: Text(
                            "Discount",
                            style: TextStyle(fontSize: screenWidth * 0.035),
                          ),
                        ),
                        Text(
                          "Rs. $discount",
                          style: TextStyle(
                              fontSize: screenWidth * 0.035,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(
                      height: 5,
                      thickness: 0.5,
                      color: Colors.grey,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: screenWidth * 0.4,
                          child: Text(
                            "Total",
                            style: TextStyle(fontSize: screenWidth * 0.035),
                          ),
                        ),
                        Text(
                          "Rs. ${isRefundable ? doctorFee + clinicFee + refundableFee + eChanneling - discount : doctorFee + clinicFee + eChanneling - discount}",
                          style: TextStyle(
                              fontSize: screenWidth * 0.035,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.2),
                width: double.infinity,
                height: screenHeight * 0.05,
                child: isLoading
                    ? const SpinKitThreeBounce(
                        color: Colors.blue,
                        size: 25.0,
                      )
                    : TextButton(
                        onPressed: () {
                          _submitAppointment(user);
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: const Color(0xFF2980B9),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        child: Text(
                          "Pay",
                          style: TextStyle(
                              fontSize: screenWidth * 0.04,
                              color: Colors.white),
                        ),
                      ),
              ),
              SizedBox(
                height: screenHeight * 0.07,
              ),
            ],
          ),
        ));
  }
}
