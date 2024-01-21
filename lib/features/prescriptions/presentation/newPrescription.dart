import 'package:MedInvent/features/prescriptions/data/myPrescriptions.dart';
import 'package:MedInvent/features/prescriptions/model/myPrescription.dart';
import 'package:MedInvent/features/prescriptions/model/newPrescribeMedicine.dart';
import 'package:MedInvent/features/prescriptions/model/prescribedMedicine.dart';
import 'package:MedInvent/features/prescriptions/presentation/NewPrescription_1.dart';
import 'package:MedInvent/features/prescriptions/presentation/NewPrescription_2.dart';
import 'package:MedInvent/features/prescriptions/presentation/NewPrescription_3.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewPrescription extends StatefulWidget {
  final MyPrescription newPrescription;
  final VoidCallback updatePresScreen;
  const NewPrescription(
      {super.key,
      required this.newPrescription,
      required this.updatePresScreen});

  @override
  State<NewPrescription> createState() => _NewPrescriptionState();
}

class _NewPrescriptionState extends State<NewPrescription> {
  void updateUI() {
    setState(() {});
  }

  TextEditingController title = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF474CA0),
                Color(0xFF468FA0),
              ],
            ),
          ),
        ),
        title: const Text("New Prescription"),
      ),
      body: SingleChildScrollView(
        child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF474CA0),
                  Color(0xFF468FA0),
                ],
              ),
            ),
            child: Container(
              margin: EdgeInsets.only(top: screenHeight * 0.025),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50.0),
                    topRight: Radius.circular(50.0),
                  )),
              child: Column(
                children: [
                  SizedBox(
                    height: screenHeight * 0.05,
                  ),
                  Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
                      child: TitleInput(label: "Title", controller: title)),
                  SizedBox(
                    height: screenHeight * 0.05,
                  ),
                  ...widget.newPrescription.prescribedMedicine.map((e) {
                    return Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
                      child: DrugTemplate(medicine: e),
                    );
                  }),
                  SizedBox(
                    height: screenHeight * 0.05,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          showModalBottomSheet(
                            isScrollControlled: true,
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(screenHeight * 0.05)),
                            ),
                            context: context,
                            builder: (BuildContext context) {
                              return AddNewMedicine(
                                newPrescription: widget.newPrescription,
                                updateUI: updateUI,
                              );
                            },
                          );
                        },
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(screenHeight * 0.05),
                            side: const BorderSide(color: Color(0xFF2980B9)),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.05),
                          child: Text(
                            "Add Medicine",
                            style: TextStyle(
                                color: const Color(0xFF2980B9),
                                fontSize: screenHeight * 0.015),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  if (widget.newPrescription.prescribedMedicine.isNotEmpty)
                    TextButton(
                      onPressed: () {
                        widget.newPrescription.title = title.text;
                        widget.newPrescription.dateIssued =
                            DateFormat('yyyy/MM/dd').format(DateTime.now());
                        myPrescriptions.add(widget.newPrescription);
                        widget.updatePresScreen();
                        Navigator.pop(context);
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: const Color(0xFF2980B9),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(screenHeight * 0.05),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.08),
                        child: Text(
                          "Submit",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: screenHeight * 0.018,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            )),
      ),
    );
  }
}

class AddNewMedicine extends StatefulWidget {
  final MyPrescription newPrescription;
  final VoidCallback updateUI;

  const AddNewMedicine(
      {super.key, required this.newPrescription, required this.updateUI});

  @override
  State<AddNewMedicine> createState() => _AddNewMedicineState();
}

class _AddNewMedicineState extends State<AddNewMedicine> {
  final PageController _pageController = PageController(initialPage: 0);
  final NewPrescribedMedicine newMed = NewPrescribedMedicine();

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      height: screenHeight * 0.87,
      child: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            SearchMedicine(pageController: _pageController, newMed: newMed),
            MedicineDetails(
                pageController: _pageController,
                newMed: newMed,
                newPres: widget.newPrescription),
            Reminders(
                pageController: _pageController,
                newMed: newMed,
                newPrescription: widget.newPrescription,
                updateUI: widget.updateUI),
          ]),
    );
  }
}

class DrugTemplate extends StatefulWidget {
  final PrescribedMedicine medicine;

  const DrugTemplate({Key? key, required this.medicine}) : super(key: key);

  @override
  State<DrugTemplate> createState() => _DrugTemplateState();
}

class _DrugTemplateState extends State<DrugTemplate> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    Color daysLeftColor =
        widget.medicine.daysLeft < 3 ? Colors.red : Colors.green;

    return Column(
      children: [
        Row(
          children: [
            Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(screenHeight * 0.02),
                    border: Border.all(
                      color: Colors.grey,
                      width: 1,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(screenHeight * 0.02),
                    child: Image.asset(
                      "assets/images/drugs.png",
                      width: screenWidth * 0.15,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: screenWidth * 0.05,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: screenWidth * 0.55,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.medicine.name,
                        style: TextStyle(
                            fontSize: screenHeight * 0.02,
                            fontWeight: FontWeight.bold),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: daysLeftColor,
                          borderRadius:
                              BorderRadius.circular(screenHeight * 0.5),
                        ),
                        height: screenHeight * 0.023,
                        width: screenWidth * 0.2,
                        child: Center(
                            child: Text(
                          "${widget.medicine.daysLeft} days left",
                          style: TextStyle(
                              fontSize: screenHeight * 0.012,
                              color: Colors.white),
                        )),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.01,
                ),
                Text(
                  "Dosage : ${widget.medicine.dosage}",
                  style: TextStyle(fontSize: screenHeight * 0.015),
                ),
                SizedBox(
                  height: screenHeight * 0.003,
                ),
                Text(
                  "Quantity : ${widget.medicine.qty}",
                  style: TextStyle(fontSize: screenHeight * 0.015),
                ),
                SizedBox(
                  height: screenHeight * 0.003,
                ),
                Text(
                  "Frequency : ${widget.medicine.frequency}",
                  style: TextStyle(fontSize: screenHeight * 0.015),
                ),
                SizedBox(
                  height: screenHeight * 0.005,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.alarm,
                      size: screenHeight * 0.02,
                      color: Colors.black45,
                    ),
                    ...widget.medicine.reminders
                        .map((time) => Text(" $time | ",
                            style: TextStyle(fontSize: screenHeight * 0.015)))
                        .toList(),
                  ],
                )
              ],
            ),
          ],
        ),
        Divider(
          color: Colors.grey,
          thickness: 1,
          height: screenHeight * 0.05,
        ),
      ],
    );
  }
}

class TitleInput extends StatelessWidget {
  final String label;
  final TextEditingController controller;

  const TitleInput({Key? key, required this.label, required this.controller})
      : super(key: key);

  String? _validateInput(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a title';
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
