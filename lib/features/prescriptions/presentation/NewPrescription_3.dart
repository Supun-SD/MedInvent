import 'package:MedInvent/features/prescriptions/presentation/prescription_1.dart';
import 'package:MedInvent/components/BottomNavBar.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class Reminders extends StatefulWidget {
  const Reminders({super.key});

  @override
  State<Reminders> createState() => RemindersState();
}

class RemindersState extends State<Reminders> {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    List<Widget> reminders = [
      const RemindersDisplay(
        time: "8.00am",
        days: "everyday",
      ),
      const RemindersDisplay(
        time: "12.00pm",
        days: "everyday",
      ),
    ];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
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
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.13,
                    vertical: screenHeight * 0.01),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: reminders.length * 2 - 1,
                        itemBuilder: (BuildContext context, int index) {
                          if (index.isOdd) {
                            return const Divider(
                              color: Colors.grey,
                              thickness: 1.0,
                              height: 0.0,
                            );
                          } else {
                            return reminders[index ~/ 2];
                          }
                        },
                      ),
                      SizedBox(
                        height: screenHeight * 0.05,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              showModalBottomSheet(
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                      top:
                                          Radius.circular(screenHeight * 0.05)),
                                ),
                                context: context,
                                builder: (BuildContext context) {
                                  return const NewReminder();
                                },
                              );
                            },
                            style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(screenHeight * 0.05),
                                side:
                                    const BorderSide(color: Color(0xFF2980B9)),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: screenWidth * 0.05),
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
                      SizedBox(height: screenHeight * 0.1,),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const Prescriptions()),
                          );
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
    );
  }
}

class RemindersDisplay extends StatelessWidget {
  final String time;
  final String days;

  const RemindersDisplay({Key? key, required this.time, required this.days})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
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
            style: TextStyle(fontSize: screenHeight * 0.018),
          ),
          SizedBox(
            width: screenWidth * 0.1,
          ),
          Text(
            days,
            style: TextStyle(fontSize: screenHeight * 0.018),
          ),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.close,
                color: Colors.red,
                size: screenHeight * 0.02,
              )),
        ],
      ),
    );
  }
}

class NewReminder extends StatefulWidget {
  const NewReminder({super.key});

  @override
  State<NewReminder> createState() => _NewReminderState();
}

class _NewReminderState extends State<NewReminder> {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    const List<String> list = <String>[
      'Everyday',
      'Every other day',
    ];
    String dropdownValue = list.first;

    return SizedBox(
      height: screenHeight * 0.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Add a new Reminder",
            style: TextStyle(
                fontSize: screenWidth * 0.04, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: screenHeight * 0.02,
          ),
          const NumberPage(),
          SizedBox(
            height: screenHeight * 0.01,
          ),
          DropdownButtonHideUnderline(
            child: Container(
              height: screenHeight * 0.05,
              width: screenWidth * 0.5,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
                child: DropdownButton<String>(
                  value: dropdownValue,
                  icon: const Icon(Icons.arrow_drop_down),
                  onChanged: (String? value) {
                    setState(() {
                      dropdownValue = value!;
                    });
                  },
                  items: list.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
          SizedBox(
            height: screenHeight * 0.03,
          ),
          TextButton(
            onPressed: () {
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
                "Add",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: screenHeight * 0.018,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NumberPage extends StatefulWidget {
  const NumberPage({super.key});

  @override
  State<NumberPage> createState() => _NumberPageState();
}

class _NumberPageState extends State<NumberPage> {
  var hour = 0;
  var minute = 0;
  var timeFormat = "AM";

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                NumberPicker(
                  minValue: 0,
                  maxValue: 12,
                  value: hour,
                  zeroPad: true,
                  infiniteLoop: true,
                  itemWidth: 80,
                  itemHeight: 60,
                  onChanged: (value) {
                    setState(() {
                      hour = value;
                    });
                  },
                  textStyle: TextStyle(
                      color: Colors.grey, fontSize: screenHeight * 0.018),
                  selectedTextStyle: TextStyle(
                      color: Colors.black, fontSize: screenHeight * 0.022),
                  decoration: const BoxDecoration(
                    border: Border(
                        top: BorderSide(
                          color: Colors.grey,
                        ),
                        bottom: BorderSide(color: Colors.grey)),
                  ),
                ),
                NumberPicker(
                  minValue: 0,
                  maxValue: 59,
                  value: minute,
                  zeroPad: true,
                  infiniteLoop: true,
                  itemWidth: 80,
                  itemHeight: 60,
                  onChanged: (value) {
                    setState(() {
                      minute = value;
                    });
                  },
                  textStyle: TextStyle(
                      color: Colors.grey, fontSize: screenHeight * 0.018),
                  selectedTextStyle: TextStyle(
                      color: Colors.black, fontSize: screenHeight * 0.022),
                  decoration: const BoxDecoration(
                    border: Border(
                        top: BorderSide(
                          color: Colors.grey,
                        ),
                        bottom: BorderSide(color: Colors.grey)),
                  ),
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          timeFormat = "AM";
                        });
                      },
                      child: Container(
                        height: screenHeight * 0.05,
                        width: screenWidth * 0.1,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                              Radius.circular(screenWidth * 0.03)),
                          color: timeFormat == "AM"
                              ? Colors.blue.shade800
                              : Colors.grey.shade700,
                        ),
                        child: Center(
                          child: Text(
                            "AM",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: screenHeight * 0.018),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          timeFormat = "PM";
                        });
                      },
                      child: Container(
                        height: screenHeight * 0.05,
                        width: screenWidth * 0.1,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                              Radius.circular(screenWidth * 0.03)),
                          color: timeFormat == "PM"
                              ? Colors.blue.shade800
                              : Colors.grey.shade700,
                        ),
                        child: Center(
                          child: Text(
                            "PM",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: screenHeight * 0.018),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}


