import 'package:MedInvent/presentation/components/BottomNavBar.dart';
import 'package:MedInvent/presentation/components/sideNavBar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String username = "John Doe";
  String greeting = "Good morning and stay healthy.";
  Image profilePhoto = Image.asset("assets/images/pic.png");

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      drawer: const SideNavBar(),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF45AEA0), Color(0xFF4749A0)],
                ),
              ),
              height: screenHeight * 0.2,
              child: AppBar(
                backgroundColor: Colors.transparent,
                toolbarHeight: screenHeight * 0.2,
                elevation: 0,
                leading: Padding(
                  padding: EdgeInsets.only(bottom: screenHeight * 0.07, left: screenWidth * 0.03),
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
                    padding: EdgeInsets.only(bottom: screenHeight * 0.07, left: screenWidth * 0.03),
                    child: IconButton(
                      icon: const Icon(Icons.notifications),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: screenHeight * 0.14,
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
        ],
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
