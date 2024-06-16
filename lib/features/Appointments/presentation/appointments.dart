import 'package:MedInvent/components/CustomTabBar.dart';
import 'package:MedInvent/components/sideNavBar.dart';
import 'package:MedInvent/features/Appointments/presentation/past.dart';
import 'package:MedInvent/features/Appointments/presentation/upcoming.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Appointments extends ConsumerWidget {
  const Appointments({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: Colors.white,
        drawer: const SideNavBar(),
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black,
            size: screenHeight * 0.04,
          ),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Padding(
          padding: EdgeInsets.only(top: screenHeight * 0.015),
          child: const CustomTabBar(
            tabTitles: ["Upcoming appointments", "Past Appointments"],
            tabViews: [
              Upcoming(),
              Past(),
            ],
          ),
        ));
  }
}
