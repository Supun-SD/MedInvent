import 'package:MedInvent/features/prescriptions/model/myPrescription.dart';
import 'package:MedInvent/features/prescriptions/model/newPrescribeMedicine.dart';
import 'package:MedInvent/features/prescriptions/model/prescribedMedicine.dart';
import 'package:flutter/material.dart';

class Reminders extends StatefulWidget {
  final PageController pageController;
  final NewPrescribedMedicine newMed;
  final MyPrescription newPrescription;
  final VoidCallback updateUI;

  const Reminders(
      {super.key,
      required this.pageController,
      required this.newMed,
      required this.newPrescription,
      required this.updateUI});

  @override
  State<Reminders> createState() => RemindersState();
}

class RemindersState extends State<Reminders> {
  TimeOfDay selectedTime = TimeOfDay.now();
  List<String> reminders = [];

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      height: screenHeight * 0.85,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(screenHeight * 0.06),
          topRight: Radius.circular(screenHeight * 0.06),
        ),
        color: Colors.white,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.1, vertical: screenHeight * 0.01),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: screenHeight * 0.05,
              ),
              if (reminders.isNotEmpty)
                ...reminders.asMap().entries.map((entry) {
                  final index = entry.key;
                  final reminder = entry.value;
                  return RemindersDisplay(
                    time: reminder,
                    onDelete: () {
                      setState(() {
                        reminders.removeAt(index);
                      });
                    },
                  );
                }).toList(),
              SizedBox(
                height: screenHeight * 0.05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () async {
                      final TimeOfDay? timeOfDay = await showTimePicker(
                          context: context,
                          initialTime: selectedTime,
                          initialEntryMode: TimePickerEntryMode.dial);
                      if (timeOfDay != null) {
                        setState(() {
                          reminders.add(timeOfDay.format(context));
                        });
                      }
                    },
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(screenHeight * 0.05),
                        side: const BorderSide(color: Color(0xFF2980B9)),
                      ),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                      child: Text(
                        "Add reminder",
                        style: TextStyle(
                            color: const Color(0xFF2980B9),
                            fontSize: screenHeight * 0.015),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: screenHeight * 0.1,
              ),
              TextButton(
                onPressed: () {
                  widget.newPrescription.prescribedMedicine.add(
                      PrescribedMedicine(
                          widget.newMed.name,
                          widget.newMed.dosage,
                          widget.newMed.qty,
                          widget.newMed.isAfterMeal,
                          widget.newMed.frequency,
                          [...reminders],
                          widget.newMed.daysLeft));
                  widget.updateUI();
                  Navigator.pop(context);
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
                    "Add Medicine",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screenHeight * 0.018,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RemindersDisplay extends StatelessWidget {
  final String time;
  final VoidCallback onDelete;

  const RemindersDisplay({
    Key? key,
    required this.time,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
      margin: EdgeInsets.only(bottom: screenHeight * 0.015),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color(0xFFf0f0f0),
      ),
      height: screenHeight * 0.075,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.alarm,
            size: screenHeight * 0.03,
            color: Colors.blue,
          ),
          Text(
            time,
            style: TextStyle(fontSize: screenHeight * 0.02),
          ),
          SizedBox(
            width: screenWidth * 0.05,
          ),
          IconButton(
            onPressed: onDelete,
            icon: Icon(
              Icons.delete_outline_outlined,
              color: Colors.red,
              size: screenHeight * 0.02,
            ),
          ),
        ],
      ),
    );
  }
}
