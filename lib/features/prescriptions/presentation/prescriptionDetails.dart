import 'package:flutter/material.dart';
import 'package:MedInvent/components/BottomNavBar.dart';

class PrescriptionDetails extends StatefulWidget {
  const PrescriptionDetails({super.key});

  @override
  State<PrescriptionDetails> createState() => _PrescriptionDetailsState();
}

class _PrescriptionDetailsState extends State<PrescriptionDetails> {
  String name = "John Doe";
  String image = "assets/images/pic.png";
  String relationship = "Primary";

  String date = "2023/10/11";
  String pharmacy = "Sumudu Pharmacy";
  String doctor = "Dr Amith";
  String cost = "Rs. 380.00";

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: DefaultTabController(
        length: 2,
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
                title: const Text("Prescription Details"),
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
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundImage: AssetImage(image),
                                  radius: screenHeight * 0.04,
                                ),
                                SizedBox(
                                  width: screenWidth * 0.05,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      name,
                                      style: TextStyle(
                                          fontSize: screenHeight * 0.025,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: screenHeight * 0.005,
                                    ),
                                    Text(
                                      relationship,
                                      style: TextStyle(
                                          fontSize: screenHeight * 0.015),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: screenHeight * 0.03,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Fever",
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
                      padding:
                          EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                      child: const TabBar(
                        tabs: [
                          Tab(text: 'Prescription'),
                          Tab(text: 'Order details'),
                        ],
                        labelColor: Colors.blue,
                        unselectedLabelColor: Colors.black,
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: screenWidth * 0.1),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: screenHeight * 0.04,
                                ),
                                const DrugTemplate(
                                  name: "Panadol",
                                  dosage: "100mg",
                                  qty: "2 - After meal",
                                  time: ["8.00am", "4.00pm", "12.00pm"],
                                  frequency: "Every 8 hours",
                                  daysLeft: 5,
                                ),
                                const DrugTemplate(
                                  name: "Panadol",
                                  dosage: "100mg",
                                  qty: "2 - After meal",
                                  time: ["8.00am", "4.00pm", "12.00pm"],
                                  frequency: "Every 8 hours",
                                  daysLeft: 2,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: screenWidth * 0.15),
                            child: Row(
                              children: [
                                Column(
                                  children: [
                                    SizedBox(
                                      height: screenHeight * 0.03,
                                    ),
                                    const Title(
                                        icon:
                                            Icon(Icons.calendar_month_outlined),
                                        title: "Date issued"),
                                    const Title(
                                        icon: Icon(Icons.location_on),
                                        title: "Pharmacy"),
                                    const Title(
                                        icon: Icon(Icons.person),
                                        title: "Doctor"),
                                    const Title(
                                        icon: Icon(Icons.attach_money),
                                        title: "Cost"),
                                  ],
                                ),
                                Column(
                                  children: [
                                    SizedBox(
                                      height: screenHeight * 0.03,
                                    ),
                                    Data(data: date),
                                    Data(data: pharmacy),
                                    Data(data: doctor),
                                    Data(data: cost),
                                  ],
                                )
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
          ],
        ),
      ),
    );
  }
}

class DrugTemplate extends StatefulWidget {
  final String name, dosage, qty, frequency;
  final List<String> time;

  final int daysLeft;

  const DrugTemplate(
      {Key? key,
      required this.name,
      required this.dosage,
      required this.qty,
      required this.time,
      required this.frequency,
      required this.daysLeft})
      : super(key: key);

  @override
  State<DrugTemplate> createState() => _DrugTemplateState();
}

class _DrugTemplateState extends State<DrugTemplate> {

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    Color daysLeftColor = widget.daysLeft < 3 ? Colors.red : Colors.green;

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
                        widget.name,
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
                          "${widget.daysLeft} days left",
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
                  "Dosage : ${widget.dosage}",
                  style: TextStyle(fontSize: screenHeight * 0.015),
                ),
                SizedBox(
                  height: screenHeight * 0.003,
                ),
                Text(
                  "Quantity : ${widget.qty}",
                  style: TextStyle(fontSize: screenHeight * 0.015),
                ),
                SizedBox(
                  height: screenHeight * 0.003,
                ),
                Text(
                  "Dosage : ${widget.frequency}",
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
                    ...widget.time
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

class Title extends StatelessWidget {
  final Icon icon;
  final String title;

  const Title({Key? key, required this.icon, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      width: screenWidth * 0.35,
      height: screenHeight * 0.05,
      child: Row(
        children: [
          Icon(
            icon.icon,
            color: Colors.black45,
            size: screenHeight * 0.025,
          ),
          SizedBox(
            width: screenWidth * 0.02,
          ),
          Text(
            title,
            style: TextStyle(
                fontSize: screenHeight * 0.018, color: Colors.black45),
          ),
        ],
      ),
    );
  }
}

class Data extends StatelessWidget {
  final String data;

  const Data({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      width: screenWidth * 0.35,
      height: screenHeight * 0.05,
      child: Row(
        children: [
          Text(
            data,
            style:
                TextStyle(fontSize: screenHeight * 0.018, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
