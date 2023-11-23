import 'package:MedInvent/presentation/components/BottomNavBar.dart';
import 'package:MedInvent/presentation/components/sideNavBar.dart';
import 'package:flutter/material.dart';
import 'package:MedInvent/presentation/components/medication_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String username = "John Doe";
  String greeting = "Good morning and stay healthy.";
  String medication1 ="Fever";
  String medication2 ="Diabetes";
  Image profilePhoto = Image.asset("assets/images/pic.png");
  final _controller= PageController();

  @override
  Widget build(BuildContext context) {
    String username1 = "Amali";
    String username = "John Doe";
    String greeting = "Good morning and stay healthy.";
    Image profilePhoto = Image.asset("assets/images/pic.png");

    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white60,
      drawer: const SideNavBar(),
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
                color: Colors.white,
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.08,
                      vertical: screenHeight * 0.05),
                  child: Padding(
                    padding: EdgeInsets.only(bottom: screenHeight * 0.1),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                      ],
                    ),
                  ),
                ),
              ),
            ),
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
                                fontSize: screenHeight * 0.03, fontWeight: FontWeight.bold),
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
              bottom: screenHeight*0.5,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Container(
                    height: screenHeight*0.25,
                    child: PageView(
                      scrollDirection: Axis.horizontal,
                      controller: _controller,
                      children: [
                        Medication_card(
                            screenHeight: screenHeight,
                            screenWidth: screenWidth,
                            medication1: medication1,
                            medication2: medication2,
                            User:username,
                            color:Colors.white ,
                        ),
                        Medication_card(
                            screenHeight: screenHeight,
                            screenWidth: screenWidth,
                            medication1: medication1,
                            medication2: medication2,
                            User:username1,
                            color:Colors.white
                        ),
                      ],
                    ),
                  ),
                ],
              )
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
