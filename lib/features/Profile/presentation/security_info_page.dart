import 'package:MedInvent/features/Profile/presentation/basic_info_page.dart';
import 'package:flutter/material.dart';
import 'package:MedInvent/components/input_field_edit.dart';
import 'package:MedInvent/components/Savebutton.dart';

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
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.07,),
                  child: Column(
                    children: [
                      const AddText(
                        text: 'Security Information',
                        topValue: 41.8,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: screenHeight * 0.02, horizontal: screenWidth * 0.02),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 0,
                              blurRadius: 70,
                            ),
                          ],
                        ),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Info(
                              label: "Email",
                              data: "sample@gmail.com",
                            ),
                            Info(
                              label: "Mobile Number",
                              data: "0778646255",
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
      margin: EdgeInsets.only(top: topValue, left: 10, bottom: 15),
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
