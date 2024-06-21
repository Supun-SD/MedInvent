import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBar(
      {super.key, required this.currentIndex, required this.onTap});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      padding: EdgeInsets.only(top: screenHeight * 0.015),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF45AEA0), Color(0xFF4749A0)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
      ),
      child: SizedBox(
        height: screenHeight * 0.08,
        child: BottomNavigationBar(
          onTap: widget.onTap,
          currentIndex: widget.currentIndex,
          selectedItemColor: Colors.white,
          backgroundColor: Colors.transparent,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.edit_document,
                size: screenHeight * 0.035,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.calendar_month,
                size: screenHeight * 0.035,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home_filled,
                size: screenHeight * 0.035,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                size: screenHeight * 0.035,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.account_circle,
                size: screenHeight * 0.035,
              ),
              label: '',
            ),
          ],
        ),
      ),
    );
  }
}
