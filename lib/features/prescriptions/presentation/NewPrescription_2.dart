import 'package:MedInvent/features/prescriptions/model/NewPrescription.dart';
import 'package:flutter/material.dart';

class MedicineDetails extends StatefulWidget {
  final PageController pageController;
  final NewPresMedicine newMed;
  final NewPrescription newPres;

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

  String frq = "Once Daily";
  int qty = 0;
  int duration = 0;
  String mealTiming = 'After';

  List<String> frequencies = [
    "Once Daily",
    "Twice Daily",
    "3 Times Daily",
    "4 Times Daily",
    "Every 4 Hours",
    "Every 6 Hours",
    "Every 8 Hours",
    "Every 12 Hours",
    "Once Weekly",
    "Twice Weekly",
    "Every Other Day",
    "At Bedtime",
    "As Needed"
  ];

  @override
  void dispose() {
    dosage.dispose();
    super.dispose();
  }

  void showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

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
                          value: frq,
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
                              frq = newValue!;
                            });
                          },
                          items: frequencies
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
                  height: screenHeight * 0.02,
                ),
                Row(
                  children: [
                    SizedBox(
                        width: screenWidth * 0.3,
                        child: Text(
                          "Quantity",
                          style: TextStyle(fontSize: screenWidth * 0.037),
                        )),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            qty.toString(),
                            style: TextStyle(fontSize: screenWidth * 0.045),
                          ),
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      if (qty > 0) {
                                        qty--;
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
                                      qty++;
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
                          "Duration",
                          style: TextStyle(fontSize: screenWidth * 0.037),
                        )),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            duration.toString(),
                            style: TextStyle(fontSize: screenWidth * 0.045),
                          ),
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      if (duration > 0) {
                                        duration--;
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
                                      duration++;
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
                          "Meal Timing",
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
                          value: mealTiming,
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
                              mealTiming = newValue!;
                            });
                          },
                          items: <String>['Before', 'After', 'With']
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
                    if (duration == 0) {
                      return;
                    }
                    if (qty == 0) {
                      return;
                    }
                    if (_formKey.currentState?.validate() ?? false) {
                      widget.newMed.frq = frq.toString();
                      widget.newMed.qty = int.parse(qty.toString());
                      widget.newMed.duration = int.parse(duration.toString());
                      widget.newMed.mealTiming = mealTiming.toString();
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
