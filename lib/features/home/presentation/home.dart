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
              height: 170,
              child: AppBar(
                backgroundColor: Colors.transparent,
                toolbarHeight: 130,
                elevation: 0,
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
              ),
            ),
          ),
          Positioned(
            top: 120,
            left: 35,
            right: 35,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    spreadRadius: 10,
                    blurRadius: 50,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 65,
                      height: 65,
                      child: profilePhoto,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            greeting,
                            style: const TextStyle(fontSize: 11),
                          ),
                          Text(
                            "Hi $username!",
                            style: const TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
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
