import 'package:MedInvent/features/Search/appointmentSuccess.dart';
import 'package:MedInvent/features/Search/models/appointment.dart';
import 'package:flutter/material.dart';

class AppointmentConfirmation extends StatefulWidget {
  const AppointmentConfirmation(
      {required this.appointment, required this.doctor, super.key});
  final Appointment appointment;
  final String doctor;

  @override
  State<AppointmentConfirmation> createState() =>
      _AppointmentConfirmationState();
}

class _AppointmentConfirmationState extends State<AppointmentConfirmation> {
  List<String> titles = ["Mr", "Ms", "Mrs"];

  String selectedTitle = "Mr";

  int doctorFee = 2300;
  int clinicFee = 1000;
  int eChanneling = 600;
  int discount = 200;
  int refundableFee = 250;
  bool isRefundable = true;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

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
                    horizontal: screenHeight * 0.05,
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
                  horizontal: screenHeight * 0.05,
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
                              SizedBox(
                                height: 35,
                                child: TextField(
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.grey[200],
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50.0),
                                      borderSide: BorderSide.none,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50.0),
                                      borderSide: const BorderSide(
                                          color: Colors.grey, width: 1),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50.0),
                                      borderSide: BorderSide.none,
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 7.5, horizontal: 15),
                                  ),
                                ),
                              ),
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
                    SizedBox(
                      height: 35,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[200],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.0),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.0),
                            borderSide:
                                const BorderSide(color: Colors.grey, width: 1),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.0),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 7.5, horizontal: 15),
                        ),
                      ),
                    ),
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
                    SizedBox(
                      height: 35,
                      child: TextField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[200],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.0),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.0),
                            borderSide:
                                const BorderSide(color: Colors.grey, width: 1),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.0),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 7.5, horizontal: 15),
                        ),
                      ),
                    ),
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
                              SizedBox(
                                height: 35,
                                child: TextField(
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.grey[200],
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50.0),
                                      borderSide: BorderSide.none,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50.0),
                                      borderSide: const BorderSide(
                                          color: Colors.grey, width: 1),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50.0),
                                      borderSide: BorderSide.none,
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 7.5, horizontal: 15),
                                  ),
                                ),
                              ),
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
                            SizedBox(
                              height: 35,
                              child: TextField(
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.grey[200],
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(50.0),
                                    borderSide: BorderSide.none,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(50.0),
                                    borderSide: const BorderSide(
                                        color: Colors.grey, width: 1),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(50.0),
                                    borderSide: BorderSide.none,
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 7.5, horizontal: 15),
                                ),
                              ),
                            ),
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
                    horizontal: screenHeight * 0.05,
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
                margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.12),
                width: double.infinity,
                height: screenHeight * 0.05,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AppointmentSuccess()),
                    );
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
                        fontSize: screenWidth * 0.04, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.07,),
            ],
          ),
        ));
  }
}
