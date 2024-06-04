import 'package:MedInvent/providers/prescriptionsProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';

class RemindersUpdate extends ConsumerStatefulWidget {
  final List<String> reminders;
  final String medicineId;
  final String presId;
  final void Function(List<String>) updateReminders;
  const RemindersUpdate({
    required this.reminders,
    required this.medicineId,
    required this.presId,
    required this.updateReminders,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<RemindersUpdate> createState() => RemindersUpdateState();
}

class RemindersUpdateState extends ConsumerState<RemindersUpdate> {
  TimeOfDay selectedTime = TimeOfDay.now();

  List<String> reminders = [];

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  String convertTimeTo24HourFormat(String time) {
    DateFormat inputFormat = DateFormat.jm();
    DateFormat outputFormat = DateFormat('HH:mm:ss');

    DateTime dateTime = inputFormat.parse(time);

    String formattedTime = outputFormat.format(dateTime);

    return formattedTime;
  }

  Future<void> onSubmitClick() async {
    if (reminders.isEmpty) {
      return;
    }

    setState(() {
      isLoading = true;
    });

    await ref.read(prescriptionsProvider.notifier).updatePrescription(
        widget.presId, widget.medicineId, reminders, context);

    setState(() {
      isLoading = false;
    });
  }

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
                          reminders.add(convertTimeTo24HourFormat(
                              timeOfDay.format(context)));
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
                        "Add a reminder",
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
              isLoading
                  ? const SpinKitThreeBounce(
                      color: Colors.blue,
                      size: 30.0,
                    )
                  : TextButton(
                      onPressed: () {
                        onSubmitClick();
                        widget.updateReminders(reminders);
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

  String convertTimeTo12HourFormat(String time24) {
    DateFormat inputFormat = DateFormat('HH:mm:ss');
    DateFormat outputFormat = DateFormat.jm();

    DateTime dateTime = inputFormat.parse(time24);

    String formattedTime = outputFormat.format(dateTime);

    return formattedTime;
  }

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
            convertTimeTo12HourFormat(time),
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
