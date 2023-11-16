import 'package:MedInvent/features/Profile/presentation/main_profile_page.dart';
import 'package:flutter/material.dart';

class SideNavBar extends StatefulWidget {
  const SideNavBar({super.key});

  @override
  State<SideNavBar> createState() => _SideNavBarState();
}

class _SideNavBarState extends State<SideNavBar> {
  String username = "John Doe";
  String email = "johndoe@gmail.com";
  Image profilePhoto = Image.asset("assets/images/pic.png");

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Drawer(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(screenHeight * 0.03),
            bottomRight: Radius.circular(screenHeight * 0.03)),
      ),
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              username,
              style: TextStyle(fontSize: screenHeight * 0.025),
            ),
            accountEmail: Text(
              email,
              style: TextStyle(fontSize: screenHeight * 0.012),
            ),
            currentAccountPicture: Container(
              margin: EdgeInsets.only(bottom: screenHeight * 0.005),
              child: CircleAvatar(
                child: profilePhoto,
              ),
            ),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF45AEA0), Color(0xFF4749A0)],
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home, size: screenHeight * 0.03),
            title: Text(
              'Home',
              style: TextStyle(fontSize: screenHeight * 0.018),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.calendar_month, size: screenHeight * 0.03),
            title: Text(
              'Appointments',
              style: TextStyle(fontSize: screenHeight * 0.018),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.location_on, size: screenHeight * 0.03),
            title: Text(
              'Map',
              style: TextStyle(fontSize: screenHeight * 0.018),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.search, size: screenHeight * 0.03),
            title: Text(
              'Search',
              style: TextStyle(fontSize: screenHeight * 0.018),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.newspaper_rounded, size: screenHeight * 0.03),
            title: Text(
              'News Feed',
              style: TextStyle(fontSize: screenHeight * 0.018),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.account_circle,size: screenHeight * 0.03),
            title: Text('Profile',style: TextStyle(fontSize: screenHeight * 0.018),),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfilePage(),
                  ));
            },
          ),
          SizedBox(
            height: screenHeight * 0.2,
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app, size: screenHeight * 0.03),
            title: Text(
              'Logout',
              style: TextStyle(fontSize: screenHeight * 0.018),
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
