import 'package:MedInvent/features/Profile/data/models/Profile.dart';
import 'package:MedInvent/features/Profile/data/models/familyMember.dart';
import 'package:MedInvent/features/prescriptions/model/Prescription.dart';
import 'package:MedInvent/features/prescriptions/presentation/PrescriptionTemplate.dart';
import 'package:MedInvent/features/prescriptions/presentation/ReminersUpdate.dart';
import 'package:flutter/material.dart';

class PrescriptionDetails extends StatefulWidget {
  final Prescription prescription;
  final VoidCallback updatePrescriptionsScreen;
  const PrescriptionDetails(
      {required this.prescription,
      required this.updatePrescriptionsScreen,
      super.key});

  @override
  State<PrescriptionDetails> createState() => _PrescriptionDetailsState();
}

class _PrescriptionDetailsState extends State<PrescriptionDetails> {
  String image = "assets/images/pic.png";

  void updateUI(Profile fm) {
    setState(() {
      widget.prescription.assignedTo = fm;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          height: screenHeight * 0.3,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF474CA0),
                Color(0xFF468FA0),
              ],
            ),
          ),
        ),
        title: const Text("Prescription details"),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF474CA0),
              Color(0xFF468FA0),
            ],
          ),
        ),
        child: DefaultTabController(
          length: 2,
          child: Container(
            margin: EdgeInsets.only(top: screenHeight * 0.025),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(screenHeight * 0.06),
                topRight: Radius.circular(screenHeight * 0.06),
              ),
              color: Colors.white,
            ),
            child: Column(
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.1,
                        vertical: screenHeight * 0.05),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        widget.prescription.assignedTo != null
                            ? Row(
                                children: [
                                  CircleAvatar(
                                    backgroundImage: AssetImage(image),
                                    radius: screenHeight * 0.04,
                                  ),
                                  SizedBox(
                                    width: screenWidth * 0.05,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.prescription.assignedTo!.name,
                                        style: TextStyle(
                                            fontSize: screenHeight * 0.025,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: screenHeight * 0.005,
                                      ),
                                      if (widget.prescription.assignedTo
                                          is FamilyMember)
                                        Text(
                                          widget.prescription.assignedTo!
                                              .relationship,
                                          style: TextStyle(
                                              fontSize: screenHeight * 0.015),
                                        ),
                                    ],
                                  )
                                ],
                              )
                            : Row(
                                children: [
                                  Text(
                                    "Not Assigned",
                                    style: TextStyle(
                                        fontSize: screenHeight * 0.017),
                                  ),
                                  const Spacer(),
                                  TextButton(
                                    onPressed: () {
                                      showModalBottomSheet(
                                        backgroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(
                                                  screenHeight * 0.05)),
                                        ),
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AssignPrescription(
                                            prescription: widget.prescription,
                                            onAssignPressed:
                                                (Profile selectedProfile) {
                                              updateUI(selectedProfile);
                                              widget
                                                  .updatePrescriptionsScreen();
                                            },
                                          );
                                        },
                                      );
                                    },
                                    style: TextButton.styleFrom(
                                      backgroundColor: const Color(0xFF2980B9),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            screenHeight * 0.05),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: screenWidth * 0.02),
                                      child: Text(
                                        "Assign",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: screenHeight * 0.015),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                        SizedBox(
                          height: screenHeight * 0.03,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.prescription.presName,
                              style: TextStyle(
                                  fontSize: screenHeight * 0.02,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                  child: const TabBar(
                    tabs: [
                      Tab(text: 'Prescription'),
                      Tab(text: 'Details'),
                    ],
                    labelColor: Colors.blue,
                    unselectedLabelColor: Colors.black,
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                        child: Column(
                          children: [
                            SizedBox(
                              height: screenHeight * 0.04,
                            ),
                            ...widget.prescription.presMedicine
                                .map((medicine) => DrugTemplate(
                                      medicine: medicine,
                                      prescription: widget.prescription,
                                    ))
                                .toList(),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.14,
                            vertical: screenHeight * 0.05),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: screenWidth * 0.38,
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.calendar_month,
                                        color: Colors.grey,
                                        size: screenWidth * 0.05,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        widget.prescription.createdBy ==
                                                "doctor"
                                            ? "Date issued"
                                            : "Date created",
                                        style: TextStyle(
                                            fontSize: screenWidth * 0.035,
                                            color: Colors.grey),
                                      )
                                    ],
                                  ),
                                ),
                                Text(
                                  widget.prescription.createdAt.split('T')[0],
                                  style: TextStyle(
                                      fontSize: screenWidth * 0.035,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            SizedBox(
                              height: screenHeight * 0.02,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: screenWidth * 0.38,
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.account_circle_outlined,
                                        color: Colors.grey,
                                        size: screenWidth * 0.05,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "Doctor",
                                        style: TextStyle(
                                            fontSize: screenWidth * 0.035,
                                            color: Colors.grey),
                                      )
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    (widget.prescription.doctorName == "")
                                        ? 'N/A'
                                        : widget.prescription.doctorName,
                                    style: TextStyle(
                                        fontSize: screenWidth * 0.035,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DrugTemplate extends StatefulWidget {
  final PresMedicine medicine;
  final Prescription prescription;

  const DrugTemplate(
      {Key? key, required this.medicine, required this.prescription})
      : super(key: key);

  @override
  State<DrugTemplate> createState() => _DrugTemplateState();
}

class _DrugTemplateState extends State<DrugTemplate> {

  List<String> reminders = [];

  @override
  void initState() {
    if (widget.medicine.reminders != null) {
      reminders = [...widget.medicine.reminders!];
    }
    super.initState();
  }

  void updateReminders(List<String> newReminders) {
    setState(() {
      reminders = [...newReminders];
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    Color daysLeftColor = widget.medicine.remainingDays <
            3
        ? Colors.red
        : Colors.green;

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
                            fontSize: screenHeight * 0.018,
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
                          widget.medicine.remainingDays <
                                  0
                              ? 'Finished'
                              : '${widget.medicine.remainingDays} days left',
                          style: TextStyle(
                            fontSize: screenHeight * 0.012,
                            color: Colors.white,
                          ),
                        )),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.01,
                ),
                Text(
                  "Quantity : ${widget.medicine.qty}",
                  style: TextStyle(fontSize: screenHeight * 0.015),
                ),
                SizedBox(
                  height: screenHeight * 0.003,
                ),
                Text(
                  "Meal Timing : ${widget.medicine.mealTiming} meals",
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
                    if (widget.medicine.reminders != null)
                      Icon(
                        Icons.alarm,
                        size: screenHeight * 0.02,
                        color: Colors.black45,
                      ),
                    if (reminders.isNotEmpty)
                      ...reminders
                          .map((time) => Text(" $time | ",
                              style: TextStyle(fontSize: screenHeight * 0.015)))
                          .toList(),
                    if (reminders.isEmpty)
                      Text(
                        "Reminders not set",
                        style: TextStyle(
                            fontSize: screenHeight * 0.015, color: Colors.grey),
                      ),
                    if (reminders.isEmpty)
                      IconButton(
                        iconSize: 20,
                        icon: const Icon(Icons.add_alarm_rounded),
                        onPressed: () {
                          showModalBottomSheet(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(screenHeight * 0.05),
                              ),
                            ),
                            context: context,
                            isScrollControlled: true,
                            builder: (BuildContext context) {
                              return SizedBox(
                                height: screenHeight * 0.75,
                                child: RemindersUpdate(
                                    updateReminders: updateReminders,
                                    reminders: reminders,
                                    medicineId: widget.medicine.medicineId!,
                                    presId: widget.prescription.prescriptionId),
                              );
                            },
                          );
                        },
                      ),
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
