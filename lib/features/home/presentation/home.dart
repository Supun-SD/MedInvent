import 'package:MedInvent/components/BottomNavBar.dart';
import 'package:MedInvent/components/sideNavBar.dart';
import 'package:flutter/material.dart';
import 'package:MedInvent/components/medication_card.dart';
import 'package:MedInvent/features/Daily_medication/Presentation/daily_medication.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String username = "John Doe";
  String greeting = "Good morning and stay healthy.";
  String medication1 = "Fever";
  String medication2 = "Diabetes";
  Image profilePhoto = Image.asset("assets/images/pic.png");
  final _controller = PageController();
  String username1 = "Amali";

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      drawer: const SideNavBar(),
      body: Stack(
        children: [
          AppBar(
            leading: Padding(
              padding: const EdgeInsets.only(bottom: 50, left: 15),
              child: Builder(
                builder: (BuildContext context) {
                  return IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                  );
                },
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 15, bottom: 50),
                child: IconButton(
                  icon: const Icon(Icons.notifications),
                  onPressed: () {},
                ),
              ),
            ],
            elevation: 0,
            backgroundColor: Colors.transparent,
            flexibleSpace: Container(
              height: screenHeight * 0.165,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF474CA0),
                    Color(0xFF468FA0),
                  ], // Example gradient colors
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            toolbarHeight: screenHeight * 0.1,
          ),
          Positioned(
            top: screenHeight * 0.1,
            left: screenWidth * 0.08,
            right: screenWidth * 0.08,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    spreadRadius: screenHeight * 0.02,
                    blurRadius: screenHeight * 0.1,
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: screenHeight * 0.025),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: screenWidth * 0.15,
                      height: screenWidth * 0.15,
                      child: profilePhoto,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: screenWidth * 0.05),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            greeting,
                            style: TextStyle(fontSize: screenHeight * 0.014),
                          ),
                          Text(
                            "Hi $username!",
                            style: TextStyle(
                                fontSize: screenHeight * 0.03,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: screenHeight * 0.25,
            child: Column(
              children: [
                SizedBox(
                  height: screenHeight * 0.25,
                  child: PageView(
                    scrollDirection: Axis.horizontal,
                    controller: _controller,
                    children: [
                      InkWell(
                        child: Medication_card(
                          screenHeight: screenHeight,
                          screenWidth: screenWidth,
                          medication1: medication1,
                          medication2: medication2,
                          User: username,
                          color: Colors.white,
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const DailyMed()),
                          );
                        },
                      ),
                      InkWell(
                        child: Medication_card(
                            screenHeight: screenHeight,
                            screenWidth: screenWidth,
                            medication1: medication1,
                            medication2: medication2,
                            User: username1,
                            color: Colors.white),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const DailyMed()),
                          );
                        },
                      )

                      // Mybutton(
                      //   iconData1: Icons.perm_identity,
                      //   buttonText1: 'Basic Information',
                      //   buttonText2: 'Name,NIC,Gender,DOB..',
                      //   iconData2: Icons.navigate_next,
                      //   onTap: () {
                      //     Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //           builder: (context) => const DailyMed()),
                      //     );
                      //   },
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class Mybutton extends StatelessWidget {
  const Mybutton({
    super.key,
    required this.iconData1,
    required this.buttonText1,
    required this.buttonText2,
    required this.iconData2,
    required this.onTap,
  });

  final IconData iconData1;
  final String buttonText1;
  final String buttonText2;
  final IconData iconData2;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: SizedBox(
        height: 62,
        width: 288,
        child: Row(
          children: [
            Icon(
              iconData1,
              color: Colors.blue,
            ),
            Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: 62,
                  margin: const EdgeInsets.only(right: 15, top: 5),
                  width: 200,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          buttonText1,
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          buttonText2,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black45,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ]),
                )),
            Icon(
              iconData2,
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}
