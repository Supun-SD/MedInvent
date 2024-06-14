import 'package:MedInvent/features/login/data/models/user_model.dart';
import 'package:MedInvent/providers/authProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:MedInvent/features/Register/presentation/pages/landing_page.dart';
import 'package:MedInvent/features/home/presentation/mainPage.dart';
import 'dart:convert';

class CheckAuth extends ConsumerStatefulWidget {
  const CheckAuth({Key? key}) : super(key: key);

  @override
  ConsumerState<CheckAuth> createState() => _CheckAuthState();
}

class _CheckAuthState extends ConsumerState<CheckAuth> {
  bool is_Authenticated = false;
  String username = "";
  String password = "";

  @override
  @override
  void initState() {
    super.initState();
    _checkAuth().then((_) {
      checkMessage();
    });
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   checkMessage();
  // }

  Future<void> _checkAuth() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString('username');
    String? password = prefs.getString('password');
    String? userJson = prefs.getString('user');

    late User user;

    if (username != null && password != null && userJson != null) {
      Map<String, dynamic> userMap = jsonDecode(userJson);
      user = User.fromJson(userMap);
      setState(() {
        this.password = password;
        this.username = username;
        is_Authenticated = true;
      });
      Future.delayed(Duration.zero, () {
        ref.watch(userProvider.notifier).setUser(user);
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
          Map<String, dynamic> messageData =
              json.decode(pushArguments["message"]);
          final getPassword = messageData["password"];
          final getOTP = messageData["OTP"];
          print('get password $getPassword');
          print('OTP is $getOTP');
          print('shared preferences password $password');
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
              '/landing',
              arguments: getarguments,
            );
          }
        }
      } else {
        if (is_Authenticated) {
          print(is_Authenticated);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const Home(sideNavIndex: 2)),
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
    return const Scaffold();
  }
}
