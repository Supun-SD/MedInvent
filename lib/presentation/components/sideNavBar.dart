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
    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(30), bottomRight: Radius.circular(30)),
      ),
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              username,
              style: const TextStyle(fontSize: 25),
            ),
            accountEmail: Text(
              email,
              style: const TextStyle(fontSize: 12),
            ),
            currentAccountPicture: Container(
              margin: const EdgeInsets.only(bottom: 10.0),
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
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.calendar_month),
            title: const Text('Appointments'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.location_on),
            title: const Text('Map'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.search),
            title: const Text('Search'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.newspaper_outlined),
            title: const Text('News Feed'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.account_circle),
            title: const Text('Profile'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfilePage(),
                  ));
            },
          ),
          const SizedBox(
            height: 200,
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Logout'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
