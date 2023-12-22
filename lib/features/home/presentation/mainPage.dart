import 'package:MedInvent/components/BottomNavBar.dart';
import 'package:MedInvent/features/Appointments/appointments.dart';
import 'package:MedInvent/features/Profile/presentation/main_profile.dart';
import 'package:MedInvent/features/Search/search.dart';
import 'package:MedInvent/features/home/presentation/home.dart';
import 'package:MedInvent/features/prescriptions/presentation/prescription_1.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List body = [
    const Prescriptions(),
    const Appointments(),
    const HomePage(),
    const Search(),
    const ProfilePage()
  ];
  int currentIndex = 2;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: body[currentIndex],
      bottomNavigationBar: BottomNavBar(
        currentIndex: currentIndex,
        onTap: (int newIndex) {
          setState(() {
            currentIndex = newIndex;
          });
        },
      ),
    );
  }
}
