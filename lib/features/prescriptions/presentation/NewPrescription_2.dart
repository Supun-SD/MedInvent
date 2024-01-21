import 'package:MedInvent/features/prescriptions/model/myPrescription.dart';
import 'package:MedInvent/features/prescriptions/model/newPrescribeMedicine.dart';
import 'package:flutter/material.dart';

class MedicineDetails extends StatefulWidget {
  final PageController pageController;
  final NewPrescribedMedicine newMed;
  final MyPrescription newPres;

  const MedicineDetails(
      {super.key,
      required this.pageController,
      required this.newMed,
      required this.newPres});

  @override
  State<MedicineDetails> createState() => MedicineDetailsState();
}

class MedicineDetailsState extends State<MedicineDetails> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController dosage = TextEditingController();

  int frq = 0;
  int amount = 0;
  int days = 0;
  String beforeAfter = 'After';

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Form(
      key: _formKey,
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
                SizedBox(
                  height: screenHeight * 0.03,
                ),
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
                            "assets/images/drugs.png",
                            height: screenHeight * 0.08,
                          ),
                        ),
                      ),
                      Text(
                        widget.newMed.name,
                        style: TextStyle(fontSize: screenHeight * 0.025),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.03,
                ),
                Row(
                  children: [
                    SizedBox(
                        width: screenWidth * 0.3,
                        child: Text(
                          "Dosage",
                          style: TextStyle(fontSize: screenWidth * 0.037),
                        )),
                    Expanded(
                        child: InputField(label: "Dosage", controller: dosage))
                  ],
                ),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                Row(
                  children: [
                    SizedBox(
                        width: screenWidth * 0.3,
                        child: Text(
                          "Frequency",
                          style: TextStyle(fontSize: screenWidth * 0.037),
                        )),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            frq.toString(),
                            style: TextStyle(fontSize: screenWidth * 0.045),
                          ),
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      if (frq > 0) {
                                        frq--;
                                      }
                                    });
                                  },
                                  icon: Icon(
                                    Icons.remove_circle_outline,
                                    size: screenWidth * 0.075,
                                    color: const Color(0xFF2980B9),
                                  )),
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      frq++;
                                    });
                                  },
                                  icon: Icon(
                                    Icons.add_circle_outline,
                                    size: screenWidth * 0.075,
                                    color: const Color(0xFF2980B9),
                                  ))
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                Row(
                  children: [
                    SizedBox(
                        width: screenWidth * 0.3,
                        child: Text(
                          "Amount",
                          style: TextStyle(fontSize: screenWidth * 0.037),
                        )),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            amount.toString(),
                            style: TextStyle(fontSize: screenWidth * 0.045),
                          ),
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      if (amount > 0) {
                                        amount--;
                                      }
                                    });
                                  },
                                  icon: Icon(
                                    Icons.remove_circle_outline,
                                    size: screenWidth * 0.075,
                                    color: const Color(0xFF2980B9),
                                  )),
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      amount++;
                                    });
                                  },
                                  icon: Icon(
                                    Icons.add_circle_outline,
                                    size: screenWidth * 0.075,
                                    color: const Color(0xFF2980B9),
                                  ))
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                Row(
                  children: [
                    SizedBox(
                        width: screenWidth * 0.3,
                        child: Text(
                          "Days",
                          style: TextStyle(fontSize: screenWidth * 0.037),
                        )),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            days.toString(),
                            style: TextStyle(fontSize: screenWidth * 0.045),
                          ),
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      if (days > 0) {
                                        days--;
                                      }
                                    });
                                  },
                                  icon: Icon(
                                    Icons.remove_circle_outline,
                                    size: screenWidth * 0.075,
                                    color: const Color(0xFF2980B9),
                                  )),
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      days++;
                                    });
                                  },
                                  icon: Icon(
                                    Icons.add_circle_outline,
                                    size: screenWidth * 0.075,
                                    color: const Color(0xFF2980B9),
                                  ))
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                Row(
                  children: [
                    SizedBox(
                        width: screenWidth * 0.3,
                        child: Text(
                          "Before/After meal",
                          style: TextStyle(fontSize: screenWidth * 0.037),
                        )),
                    Expanded(
                      child: Container(
                        height: screenHeight * 0.045,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(color: Colors.grey, width: 1.0),
                        ),
                        child: DropdownButton<String>(
                          borderRadius: BorderRadius.circular(20),
                          dropdownColor: const Color(0xFFF5F5F5),
                          isExpanded: true,
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.04),
                          value: beforeAfter,
                          icon: const Icon(Icons.arrow_drop_down),
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: screenWidth * 0.035),
                          underline: Container(
                            height: 2,
                            color: Colors.transparent,
                          ),
                          onChanged: (String? newValue) {
                            setState(() {
                              beforeAfter = newValue!;
                            });
                          },
                          items: <String>['Before', 'After']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: screenHeight * 0.07,
                ),
                TextButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      widget.newMed.dosage = dosage.text;
                      widget.newMed.frequency = frq.toString();
                      widget.newMed.qty = int.parse(amount.toString());
                      widget.newMed.daysLeft = int.parse(days.toString());
                      widget.newMed.isAfterMeal =
                          beforeAfter.toLowerCase() == 'before'
                              ? false
                              : true;
                      widget.pageController.animateToPage(2,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut);
                    }
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: const Color(0xFF2980B9),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(screenHeight * 0.05),
                    ),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
                    child: Text(
                      "Next",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: screenHeight * 0.018,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.15,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class InputField extends StatelessWidget {
  final String label;
  final TextEditingController controller;

  const InputField({Key? key, required this.label, required this.controller})
      : super(key: key);

  String? _validateInput(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a value';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      height: screenHeight * 0.045,
      child: TextFormField(
        controller: controller,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: _validateInput,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: screenWidth * 0.05),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}
