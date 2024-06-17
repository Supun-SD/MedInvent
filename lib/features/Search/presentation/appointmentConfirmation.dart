import 'package:MedInvent/components/PatientDetailInput.dart';
import 'package:MedInvent/components/RadioButtonOption.dart';
import 'package:MedInvent/components/UserDetail.dart';
import 'package:MedInvent/features/Search/models/session.dart';
import 'package:MedInvent/features/login/data/models/user_model.dart';
import 'package:MedInvent/providers/appointmentsProvider.dart';
import 'package:MedInvent/providers/authProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';

class AppointmentConfirmation extends ConsumerStatefulWidget {
  const AppointmentConfirmation({required this.session, super.key});
  final Session session;

  @override
  ConsumerState<AppointmentConfirmation> createState() =>
      _AppointmentConfirmationState();
}

class _AppointmentConfirmationState
    extends ConsumerState<AppointmentConfirmation> {
  List<String> titles = ["Mr", "Ms", "Mrs"];
  String selectedTitle = "Mr";

  String _selectedOption = 'Other';

  int doctorFee = 2300;
  int clinicFee = 1000;
  int eChanneling = 600;
  int discount = 200;
  int refundableFee = 250;
  bool isRefundable = false;

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

    await ref.read(appointmentsProvider.notifier).createAppointment(
        context,
        _patientName.text,
        _mobileNo.text,
        _email.text,
        selectedTitle,
        _nic.text,
        _area.text,
        user,
        widget.session,
        _selectedOption);
  }

  String formatDate(String dateStr) {
    DateTime dateTime = DateTime.parse(dateStr);
    String daySuffix(int day) {
      if (day >= 11 && day <= 13) {
        return 'th';
      }
      switch (day % 10) {
        case 1:
          return 'st';
        case 2:
          return 'nd';
        case 3:
          return 'rd';
        default:
          return 'th';
      }
    }

    String weekday = DateFormat('EEE').format(dateTime);
    int day = dateTime.day;
    String month = DateFormat('MMMM').format(dateTime);

    return '$weekday, $day${daySuffix(day)} of $month';
  }

  String convertTime(String time) {
    DateTime dateTime = DateTime.parse('1970-01-01 $time');
    String formattedTime = DateFormat('h:mm a').format(dateTime);

    return formattedTime;
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    User user = ref.watch(userProvider)!;
    bool isLoading = ref.watch(appointmentsProvider).isLoading;

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
                      "${widget.session.doctor.fname} ${widget.session.doctor.mname} ${widget.session.doctor.lname} (${widget.session.doctor.specialization})",
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
                    Text(widget.session.clinic,
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
                    Text(
                        "${formatDate(widget.session.date)}   |   ${convertTime(widget.session.timeFrom)}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: screenWidth * 0.035)),
                    const Divider(
                      color: Colors.grey,
                    ),
                    Text("Active patients",
                        style: TextStyle(fontSize: screenWidth * 0.03)),
                    const SizedBox(
                      height: 5,
                    ),
                    Text((widget.session.activePatients).toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: screenWidth * 0.04)),
                    const Divider(
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
              widget.session.activePatients == widget.session.noOfPatients
                  ? Container(
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding:
                          EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                      margin: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.05,
                      ),
                      width: double.infinity,
                      child: const Text(
                        "This session is full",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    )
                  : Container(
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
                                    style: TextStyle(
                                        fontSize: screenWidth * 0.035),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
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
                                      style:
                                          const TextStyle(color: Colors.black),
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
                                      style: TextStyle(
                                          fontSize: screenWidth * 0.035),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    if (_selectedOption == 'For me')
                                      UserDetail(
                                          text: '${user.fname} ${user.lname}')
                                    else
                                      PatientDetailInput(
                                          controller: _patientName)
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
                                      style: TextStyle(
                                          fontSize: screenWidth * 0.035),
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
                                    style: TextStyle(
                                        fontSize: screenWidth * 0.035),
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
                        ],
                      ),
                    ),
              if (widget.session.activePatients != widget.session.noOfPatients)
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
                            "Rs. ${widget.session.docFee.toStringAsFixed(2)}",
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
                            "Rs. ${widget.session.clinicFee.toStringAsFixed(2)}",
                            style: TextStyle(
                                fontSize: screenWidth * 0.035,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      // Row(
                      //   children: [
                      //     SizedBox(
                      //       width: screenWidth * 0.4,
                      //       child: Text(
                      //         "e-Channeling fee",
                      //         style: TextStyle(fontSize: screenWidth * 0.035),
                      //       ),
                      //     ),
                      //     Text(
                      //       "Rs. $eChanneling",
                      //       style: TextStyle(
                      //           fontSize: screenWidth * 0.035,
                      //           fontWeight: FontWeight.bold),
                      //     )
                      //   ],
                      // ),
                      // const SizedBox(
                      //   height: 10,
                      // ),
                      // Row(
                      //   children: [
                      //     SizedBox(
                      //       width: screenWidth * 0.4,
                      //       child: Text(
                      //         "Discount",
                      //         style: TextStyle(fontSize: screenWidth * 0.035),
                      //       ),
                      //     ),
                      //     Text(
                      //       "Rs. $discount",
                      //       style: TextStyle(
                      //           fontSize: screenWidth * 0.035,
                      //           fontWeight: FontWeight.bold),
                      //     )
                      //   ],
                      // ),
                      // const SizedBox(
                      //   height: 10,
                      // ),
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
                            "Rs. ${(widget.session.docFee + widget.session.clinicFee).toStringAsFixed(2)}",
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
              if (widget.session.activePatients != widget.session.noOfPatients)
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
