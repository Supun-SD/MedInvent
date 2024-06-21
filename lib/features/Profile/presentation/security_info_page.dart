import 'package:MedInvent/features/Profile/presentation/tempBasic.dart';
import 'package:MedInvent/providers/authProvider.dart';
import 'package:flutter/material.dart';
import 'package:MedInvent/components/input_field_edit.dart';
import 'package:MedInvent/components/Savebutton.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SecurityInfo extends ConsumerStatefulWidget {
  const SecurityInfo({super.key});

  @override
  ConsumerState<SecurityInfo> createState() => SecurityInfoState();
}

class SecurityInfoState extends ConsumerState<SecurityInfo> {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    var user = ref.watch(userProvider)!;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF474CA0),
                Color(0xFF468FA0),
              ],
            ),
          ),
        ),
        title: const Text("Security Information"),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF474CA0),
                Color(0xFF468FA0),
              ],
            ),
          ),
          child: Container(
            margin: EdgeInsets.only(top: screenHeight * 0.025),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50.0),
                  topRight: Radius.circular(50.0),
                )),
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.07,
                ),
                child: Column(
                  children: [
                    const AddText(
                      text: 'Security Information',
                      topValue: 41.8,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: screenHeight * 0.02,
                          horizontal: screenWidth * 0.02),
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Info(
                            label: "Email",
                            data: user.email,
                          ),
                          Info(
                            label: "Mobile Number",
                            data: user.mobileNo,
                          ),
                          Info(
                            label: "Nic",
                            data: user.nic,
                          ),
                        ],
                      ),
                    ),
                    const AddText(
                      text: 'Change Password',
                      topValue: 41.8,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.02),
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
                      save: 'Update',
                    ),
                    SizedBox(height: screenHeight * 0.07),
                  ],
                ),
              ),
            ),
          ),
        ),
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
