import 'package:MedInvent/presentation/components/BottomNavBar.dart';
import 'package:flutter/material.dart';

import 'NewPrescription_3.dart';


class MedicineDetails extends StatefulWidget {
  const MedicineDetails({super.key});

  @override
  State<MedicineDetails> createState() => MedicineDetailsState();
}

class MedicineDetailsState extends State<MedicineDetails> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final String medName = "Panadol";
  final String medImage = 'assets/images/drugs.png';

  final TextEditingController dosage = TextEditingController();
  final TextEditingController frq = TextEditingController();
  final TextEditingController amount = TextEditingController();
  final TextEditingController days = TextEditingController();
  final TextEditingController beforeAfter = TextEditingController();
  final TextEditingController note = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Form(
        key: _formKey,
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.topRight,
                  colors: [
                    Color(0xFF474CA0),
                    Color(0xFF468FA0),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: AppBar(
                title: const Text("Add medicine"),
                elevation: 0,
                backgroundColor: Colors.transparent,
                toolbarHeight: screenHeight * 0.1,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: screenHeight * 0.85,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(screenHeight * 0.06),
                    topRight: Radius.circular(screenHeight * 0.06),
                  ),
                  color: Colors.white,
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.11),
                    child: Column(
                      children: [
                        SizedBox(height: screenHeight * 0.03,),
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFF5F5F5),
                            borderRadius: BorderRadius.circular(screenWidth * 0.08),
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(screenHeight * 0.02),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20.0),
                                  child: Image.asset(
                                    medImage,
                                    height: screenHeight * 0.08,
                                  ),
                                ),
                              ),

                              Text(
                                medName,
                                style: TextStyle(fontSize: screenHeight * 0.025),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.03,),
                        InputField(label: "Dosage", controller: dosage,),
                        SizedBox(height: screenHeight * 0.02,),
                        InputField(label: "Frequency", controller: frq,),
                        SizedBox(height: screenHeight * 0.02,),
                        InputField(label: "Amount", controller: amount,),
                        SizedBox(height: screenHeight * 0.02,),
                        InputField(label: "Days", controller: days,),
                        SizedBox(height: screenHeight * 0.02,),
                        InputField(label: "Before/after meal", controller: beforeAfter,),
                        SizedBox(height: screenHeight * 0.02,),
                        InputField(label: "Notes", controller: note,),
                        SizedBox(height: screenHeight * 0.04,),
                        TextButton(
                          onPressed: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const Reminders()),
                              );
                            }
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: const Color(0xFF2980B9),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(screenHeight * 0.05),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
                            child: Text(
                              "Next",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: screenHeight * 0.018,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.15,)
                      ],
                    ),

                  ),
                ),
              ),
            ),
            const Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: BottomNavBar(),
            ),
          ],
        ),
      ),
    );
  }
}

class InputField extends StatelessWidget {
  final String label;
  final TextEditingController controller;

  const InputField({Key? key, required this.label, required this.controller}) : super(key: key);

  String? _validateInput(String? value) {
    if (label == "Dosage" || label == "Frequency" || label == "Amount" || label == "Days") {
      if (value == null || value.isEmpty) {
        return 'Please enter a numeric value';
      }
      if (double.tryParse(value) == null) {
        return 'Please enter a valid number';
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return TextFormField(
      controller: controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: _validateInput,
      keyboardType: label == "Dosage" || label == "Frequency" || label == "Amount" || label == "Days"
          ? TextInputType.number 
          : TextInputType.text,
      decoration: InputDecoration(
        labelText: label,
        contentPadding: EdgeInsets.only(left: screenWidth * 0.05),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      ),
    );
  }
}

