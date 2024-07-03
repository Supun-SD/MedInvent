import 'package:MedInvent/features/Map/map_screen.dart';
import 'package:MedInvent/features/home/presentation/mainPage.dart';
import 'package:MedInvent/features/login/models/user_model.dart';
import 'package:MedInvent/providers/authProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SideNavBar extends ConsumerStatefulWidget {
  const SideNavBar({super.key});

  @override
  ConsumerState<SideNavBar> createState() => _SideNavBarState();
}

class _SideNavBarState extends ConsumerState<SideNavBar> {
  Image profilePhoto = Image.asset("assets/images/pic.png");

  Future<void> onLogout() async {
    await ref.watch(userProvider.notifier).logoutUser(context);
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    User user = ref.watch(userProvider).user!;
    bool isLoading = ref.watch(userProvider).isLoading;

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
              '${user.fname} ${user.lname}',
              style: TextStyle(fontSize: screenHeight * 0.025),
            ),
            accountEmail: Text(
              user.email,
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
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const Home(sideNavIndex: 2),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.calendar_month, size: screenHeight * 0.03),
            title: Text(
              'Appointments',
              style: TextStyle(fontSize: screenHeight * 0.018),
            ),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const Home(sideNavIndex: 1),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.edit_document, size: screenHeight * 0.03),
            title: Text(
              'Prescriptions',
              style: TextStyle(fontSize: screenHeight * 0.018),
            ),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const Home(sideNavIndex: 0),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.location_on, size: screenHeight * 0.03),
            title: Text(
              'Map',
              style: TextStyle(fontSize: screenHeight * 0.018),
            ),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const MapPage(selectedCategory: "all"),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.search, size: screenHeight * 0.03),
            title: Text(
              'Search',
              style: TextStyle(fontSize: screenHeight * 0.018),
            ),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const Home(sideNavIndex: 3),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.account_circle, size: screenHeight * 0.03),
            title: Text(
              'Profile',
              style: TextStyle(fontSize: screenHeight * 0.018),
            ),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const Home(sideNavIndex: 4),
                ),
              );
            },
          ),
          SizedBox(
            height: screenHeight * 0.15,
          ),
          isLoading
              ? const SpinKitThreeInOut(
                  size: 20,
                  color: Colors.blue,
                )
              : ListTile(
                  leading: Icon(Icons.exit_to_app, size: screenHeight * 0.03),
                  title: Text(
                    'Logout',
                    style: TextStyle(fontSize: screenHeight * 0.018),
                  ),
                  onTap: onLogout,
                ),
        ],
      ),
    );
  }
}
