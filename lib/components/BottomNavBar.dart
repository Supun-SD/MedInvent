import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomNavBar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;

  BottomNavBar({required this.currentIndex, required this.onTap});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return
      //GNav(
    //     rippleColor: Colors.grey, // tab button ripple color when pressed
    //     hoverColor: Colors.grey, // tab button hover color
    //     haptic: true, // haptic feedback
    //     tabBorderRadius: 15,
    //     tabActiveBorder: Border.all(color: Colors.black, width: 1), // tab button border
    //     tabBorder: Border.all(color: Colors.grey, width: 1), // tab button border
    //     tabShadow: [BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 8)], // tab button shadow
    //     curve: Curves.easeOutExpo, // tab animation curves
    //     duration: Duration(milliseconds: 900), // tab animation duration
    //     gap: 8, // the tab button gap between icon and text
    //     color: Colors.grey[800], // unselected icon color
    //     activeColor: Colors.purple, // selected icon and text color
    //     iconSize: 24, // tab button icon size
    //     tabBackgroundColor: Colors.purple.withOpacity(0.1), // selected tab background color
    //     padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5), // navigation bar padding
    //     tabs: [
    //       GButton(
    //         icon: Icons.home,
    //         text: 'Home',
    //       ),
    //       GButton(
    //         icon: Icons.map_rounded,
    //         text: 'Map',
    //       ),
    //       GButton(
    //         icon: Icons.search,
    //         text: 'Search',
    //       ),
    //       GButton(
    //         icon: Icons.account_circle,
    //         text: 'Profile',
    //       )
    //     ]
    // );
    Container(

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
