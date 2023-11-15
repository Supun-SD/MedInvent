import 'package:flutter/material.dart';
import 'package:MedInvent/presentation/components/input_field_edit.dart';
import 'package:MedInvent/presentation/components/Savebutton.dart';

class BasicInfo extends StatelessWidget {
  const BasicInfo({super.key});
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
                    Container(
                      width: 130,
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(top: 32.0),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                        // color: Colors.red,
                      ),
                      child: Image.asset(
                        'assets/images/pic.png',
                        width: 130.0,
                        height: 130.0,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    const AddText(
                      text: 'Basic Information',
                      topValue: 41.8,
                    ),
                    Container(
                      width: 356,
                      height: 340,
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
                            topic: 'First Name',
                            tvalue: 33,
                            bvalue: 24,
                            wiht: 300,
                          ),
                          Inputbutton(
                            topic: 'Last Name',
                            bvalue: 24,
                            wiht: 300,
                          ),
                          Inputbutton(
                            topic: 'NIC',
                            bvalue: 24,
                            wiht: 300,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Inputbutton(
                                topic: 'City',
                                bvalue: 24,
                                wiht: 144,
                                rvalue: 10,
                              ),
                              Inputbutton(
                                topic: 'Distric',
                                bvalue: 24,
                                wiht: 144,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    const AddText(
                      text: 'Secondary Information',
                      topValue: 41.8,
                    ),
                    Container(
                      width: 356,
                      height: 340,
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
                            topic: 'Address Line 01',
                            tvalue: 33,
                            bvalue: 24,
                            wiht: 300,
                          ),
                          Inputbutton(
                            topic: 'Address Line 02',
                            bvalue: 24,
                            wiht: 300,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Inputbutton(
                                topic: 'Gender',
                                bvalue: 24,
                                wiht: 144,
                                rvalue: 10,
                              ),
                              Inputbutton(
                                topic: 'DOB',
                                bvalue: 24,
                                wiht: 144,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Inputbutton(
                                topic: 'Height',
                                bvalue: 24,
                                wiht: 144,
                                rvalue: 10,
                              ),
                              Inputbutton(
                                topic: 'Weight',
                                bvalue: 24,
                                wiht: 144,
                              ),
                            ],
                          )
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
