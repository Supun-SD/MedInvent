import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:MedInvent/features/Register/presentation/pages/landing_page.dart';
import 'package:MedInvent/features/home/presentation/mainPage.dart';

//will need later below packages
//import 'package:jwt_decoder/jwt_decoder.dart';
//import 'package:http/http.dart' as http;
//import 'dart:convert';


class CheckAuth extends StatefulWidget {
  CheckAuth({Key? key}) : super(key: key);

  @override
  State<CheckAuth> createState() => _CheckAuthState();
}

class _CheckAuthState extends State<CheckAuth> {
  bool is_Authenticated =false;
  String username ="";
  String password ="";

  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString('username');
    String? password =prefs.getString('password');
    if (username != null && password!= null) {
      setState(() {
        is_Authenticated=true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return is_Authenticated
    ? const Home(
      sideNavIndex: 2,
    )
    : const Landing();
  }
}
