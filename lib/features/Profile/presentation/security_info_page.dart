import 'package:flutter/material.dart';
import 'package:MedInvent/presentation/components/input_field_edit.dart';
import 'package:MedInvent/presentation/components/Savebutton.dart';
import 'package:MedInvent/presentation/components/BottomNavBar.dart';

class SecurityInfo extends StatelessWidget {
  const SecurityInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
        child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.only(top: 100.0),
              height: 750,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
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
                  ],
                ),
              ),
            )),
      ),
      bottomNavigationBar: const BottomNavBar(),
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
