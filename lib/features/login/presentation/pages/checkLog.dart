import 'package:MedInvent/features/login/models/user_model.dart';
import 'package:MedInvent/providers/authProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:MedInvent/features/Register/presentation/landing_page.dart';
import 'package:MedInvent/features/home/presentation/mainPage.dart';
import 'dart:convert';

class CheckAuth extends ConsumerStatefulWidget {
  const CheckAuth({Key? key}) : super(key: key);

  @override
  ConsumerState<CheckAuth> createState() => _CheckAuthState();
}

class _CheckAuthState extends ConsumerState<CheckAuth> {
  bool is_Authenticated = false;

  @override
  @override
  void initState() {
    super.initState();
    _checkAuth().then((_) {
      checkMessage();
    });
  }

  Future<void> _checkAuth() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString('user');

    late User user;

    if (userJson != null) {
      Map<String, dynamic> userMap = jsonDecode(userJson);
      user = User.fromJson(userMap);
      setState(() {
        is_Authenticated = true;
      });
      Future.delayed(Duration.zero, () {
        ref.watch(userProvider.notifier).setUser(user);
      });
    }
  }

  void checkMessage() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final getarguments = ModalRoute.of(context)?.settings.arguments;

      if (getarguments != null) {
        print("arguments not null");
        Map? pushArguments = getarguments as Map;
        if (pushArguments.containsKey("message")) {
          Map<String, dynamic> messageData =
              json.decode(pushArguments["message"]);
          final getTitle = messageData["identify"];
          if (getTitle == "OTP") {
            Navigator.pushNamed(
              context,
              '/notifications',
              arguments: getarguments,
            );
          } else if (getTitle == "cancel") {
            Navigator.pushNamed(
              context,
              '/CancelNotification',
              arguments: getarguments,
            );
          }else if (getTitle == "arrive") {
            Navigator.pushNamed(
              context,
              '/ArriveNotification',
              arguments: getarguments,
            );
          }else if (getTitle == "medicine") {
            Navigator.pushNamed(
              context,
              '/ReminderNotification',
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
