import 'package:flutter/material.dart';
import 'package:MedInvent/presentation/components/input_field_edit.dart';
import 'package:MedInvent/presentation/components/Savebutton.dart';
import 'package:MedInvent/presentation/components/BottomNavBar.dart';

class SecurityInfo extends StatefulWidget {
  const SecurityInfo({super.key});

  @override
  State<SecurityInfo> createState() => SecurityInfoState();
}

class SecurityInfoState extends State<SecurityInfo> {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.topRight,
                colors: [
                  Color(0xFF474CA0),
                  Color(0xFF468FA0),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              title: const Text("Basic Information"),
              elevation: 0,
              backgroundColor: Colors.transparent,
              toolbarHeight: screenHeight * 0.1,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: screenHeight * 0.85,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(screenHeight * 0.06),
                  topRight: Radius.circular(screenHeight * 0.06),
                ),
                color: Colors.white,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const AddText(
                      text: 'Security Information',
                      topValue: 41.8,
                    ),
                    Container(
                      width: 356,
                      height: 192,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 30.0,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: const Column(
                        children: [
                          Inputbutton(
                            topic: 'Telephone Number',
                            tvalue: 33,
                            bvalue: 24,
                            wiht: 300,
                          ),
                          Inputbutton(
                            topic: 'Email Address',
                            bvalue: 33,
                            wiht: 300,
                          ),
                        ],
                      ),
                    ),
                    const AddText(
                      text: 'Change Password',
                      topValue: 41.8,
                    ),
                    Container(
                      width: 356,
                      height: 267,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 30.0,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: const Column(
                        children: [
                          Inputbutton(
                            topic: 'Old Password',
                            tvalue: 33,
                            bvalue: 24,
                            wiht: 300,
                          ),
                          Inputbutton(
                            topic: 'New Password',
                            bvalue: 24,
                            wiht: 300,
                          ),
                          Inputbutton(
                            topic: 'Confirm Password',
                            bvalue: 33,
                            wiht: 300,
                          ),
                        ],
                      ),
                    ),
                    SaveButton(
                      onTap: () {},
                      save: 'Save',
                    ),
                    SizedBox(height: screenHeight * 0.07),
                  ],
                ),
              ),
            ),
          ),
          const Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: BottomNavBar(),
          ),
        ],
      ),
    );
  }
}

class AddText extends StatelessWidget {
  const AddText({
    super.key,
    required this.text,
    this.topValue = 0.0,
  });
  final String text;
  final double topValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      margin: EdgeInsets.only(top: topValue, left: 48, bottom: 15),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 20,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
