import 'package:MedInvent/features/prescriptions/model/NewPrescription.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:MedInvent/features/prescriptions/presentation/NewPrescription_1.dart';
import 'package:MedInvent/features/prescriptions/presentation/NewPrescription_2.dart';
import 'package:MedInvent/features/prescriptions/presentation/NewPrescription_3.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../providers/prescriptionsProvider.dart';

class AddNewPrescription extends ConsumerStatefulWidget {
  final NewPrescription newPrescription;
  const AddNewPrescription({super.key, required this.newPrescription});

  @override
  ConsumerState<AddNewPrescription> createState() => _AddNewPrescriptionState();
}

class _AddNewPrescriptionState extends ConsumerState<AddNewPrescription> {
  TextEditingController title = TextEditingController();
  bool isLoading = false;

  String userId = "126b4f01-e486-461e-b20e-311e3c7c0ffb";

  void updateUI() {
    setState(() {});
  }

  @override
  void dispose() {
    title.dispose();
    super.dispose();
  }

  void showAlert(BuildContext context, String message, bool isError) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
      ),
    );
  }

  Future<void> onSubmitClick(
      NewPrescription prescription, BuildContext context) async {
    if (title.text.isEmpty) {
      showAlert(context, "Prescription title cannot be empty", true);
      return;
    }

    setState(() {
      isLoading = true;
    });

    prescription.presName = title.text;
    await ref
        .read(prescriptionsProvider.notifier)
        .addUserPrescription(context, prescription, userId);

    setState(() {
      isLoading = false;
    });
  }

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
                  ...widget.newPrescription.presMedicine
                      .map((medicine) => DrugTemplate(
                            medicine: medicine,
                          ))
                      .toList(),
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
                              builder: (context) => AddNewMedicine(
                                    newPrescription: widget.newPrescription,
                                    updateUI: updateUI,
                                  ));
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
                  if (widget.newPrescription.presMedicine.isNotEmpty)
                    isLoading
                        ? const SpinKitThreeBounce(
                            color: Colors.blue,
                            size: 30.0,
                          )
                        : TextButton(
                            onPressed: () {
                              widget.newPrescription.presName = title.text;
                              onSubmitClick(widget.newPrescription, context);
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
  final NewPrescription newPrescription;
  final VoidCallback updateUI;

  const AddNewMedicine(
      {super.key, required this.newPrescription, required this.updateUI});

  @override
  State<AddNewMedicine> createState() => _AddNewMedicineState();
}

class _AddNewMedicineState extends State<AddNewMedicine> {
  final PageController _pageController = PageController(initialPage: 0);
  final NewPresMedicine newMed = NewPresMedicine();

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
  final NewPresMedicine medicine;

  const DrugTemplate({Key? key, required this.medicine}) : super(key: key);

  @override
  State<DrugTemplate> createState() => _DrugTemplateState();
}

class _DrugTemplateState extends State<DrugTemplate> {
  String convertTimeTo12HourFormat(String time24) {
    DateFormat inputFormat = DateFormat('HH:mm:ss');
    DateFormat outputFormat = DateFormat.jm();

    DateTime dateTime = inputFormat.parse(time24);

    String formattedTime = outputFormat.format(dateTime);

    return formattedTime;
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    Color daysLeftColor =
        widget.medicine.duration < 3 ? Colors.red : Colors.green;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
      child: Column(
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
                            "${widget.medicine.duration} days left",
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
                    "Meal timing : ${widget.medicine.mealTiming}",
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
                    "Frequency : ${widget.medicine.frq}",
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
                          .map((time) => Text(
                              " ${convertTimeTo12HourFormat(time)} | ",
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
      ),
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
