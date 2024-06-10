import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:MedInvent/features/Register/presentation/pages/landing_page.dart';
import 'package:MedInvent/features/home/presentation/mainPage.dart';
import 'dart:convert';

class CheckAuth extends StatefulWidget {
  CheckAuth({Key? key}) : super(key: key);

  @override
  State<CheckAuth> createState() => _CheckAuthState();
}

class _CheckAuthState extends State<CheckAuth> {
  bool is_Authenticated = false;
  String username = "";
  String password = "";

  @override
  void initState() {
    super.initState();
    _checkAuth().then((_) {
      checkMessage();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    checkMessage();
  }

  Future<void> _checkAuth() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString('username');
    String? password = prefs.getString('password');
    if (username != null && password != null) {
      print(username);
      print(password);
      setState(() {
        is_Authenticated = true;
        print(is_Authenticated);
      });
    }
  }

  void checkMessage() {
    print('inside checkMessage');
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final getarguments = ModalRoute.of(context)?.settings.arguments;

      if (getarguments != null) {
        Map? pushArguments = getarguments as Map;
        if (pushArguments.containsKey("message")) {
          Map<String, dynamic> messageData = json.decode(pushArguments["message"]);
          final getPassword = messageData["password"];
          if (getPassword == password) {
            print('equal');
            Navigator.pushNamed(
              context,
              '/notifications',
              arguments: getarguments,
            );
          } else if (getPassword != password) {
            print('not equal');
            Navigator.pushNamed(
              context,
              '/',
              arguments: getarguments,
            );
          }
        }
      } else {
        if (is_Authenticated) {
          print(is_Authenticated);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const Home(sideNavIndex: 2)),
          );
        } else {
          print('landing page');
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const Landing()),
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
