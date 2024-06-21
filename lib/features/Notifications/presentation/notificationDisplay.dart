import 'package:flutter/material.dart';
import 'dart:convert';

class DisplayPage extends StatefulWidget {
  const DisplayPage({Key? key}) : super(key: key);

  @override
  State<DisplayPage> createState() => _DisplayPageState();
}

class _DisplayPageState extends State<DisplayPage> {
  String sendBy = "";
  String OTP = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    assignMessage();
  }

  void assignMessage() {
    final getarguments = ModalRoute.of(context)?.settings.arguments;
    if (getarguments != null) {
      Map? pushArguments = getarguments as Map;
      if (pushArguments.containsKey("message")) {
        Map<String, dynamic> messageData =
            json.decode(pushArguments["message"]);
        setState(() {
          sendBy = messageData["sendBy"];
          OTP = messageData["OTP"];
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.deepPurple,
        body: Center(
          child: Container(
            color: Colors.white,
            width: 500,
            height: 500,
            child: Text(
              'send by value is $sendBy , OTP value is $OTP',
            ),
          ),
        ),
      ),
    );
  }
}
