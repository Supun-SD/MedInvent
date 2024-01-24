import 'package:MedInvent/components/otp_input.dart';
import 'package:flutter/material.dart';

class AddExistingMember extends StatefulWidget {
  const AddExistingMember({super.key, required this.updateUI});

  final VoidCallback updateUI;

  @override
  State<AddExistingMember> createState() => _AddExistingMemberState();
}

class _AddExistingMemberState extends State<AddExistingMember> {
  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    return SizedBox(
      height: screenHeight * 0.4 + keyboardSpace,
      child: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            LinkProfile(
              pageController: _pageController,
            ),
            OtpVerify(
                pageController: _pageController, updateUI: widget.updateUI),
          ]),
    );
  }
}

class LinkProfile extends StatelessWidget {
  final PageController pageController;

  LinkProfile({super.key, required this.pageController});

  TextEditingController relationship = TextEditingController();
  TextEditingController mobileNo = TextEditingController();
  TextEditingController nic = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Column(
      children: [
        SizedBox(
          height: screenHeight * 0.03,
        ),
        Text(
          "Link Profile",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: screenHeight * 0.02),
        ),
        SizedBox(
          height: screenHeight * 0.02,
        ),
        Input(label: "Relationship", controller: relationship),
        Input(label: "Mobile Number", controller: mobileNo),
        Input(label: "NIC", controller: nic),
        SizedBox(
          height: screenHeight * 0.02,
        ),
        TextButton(
          onPressed: () {
            pageController.animateToPage(2,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut);
          },
          style: TextButton.styleFrom(
            backgroundColor: const Color(0xFF2980B9),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(screenHeight * 0.05),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
            child: Text(
              "Next",
              style: TextStyle(
                color: Colors.white,
                fontSize: screenHeight * 0.018,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class OtpVerify extends StatelessWidget {
  final PageController pageController;
  final VoidCallback updateUI;

  const OtpVerify(
      {super.key, required this.pageController, required this.updateUI});
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: screenHeight * 0.04,
        ),
        Text(
          "Grant access",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: screenHeight * 0.02),
        ),
        SizedBox(
          height: screenHeight * 0.04,
        ),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.15),
            child: Text(
              "Enter the confirmation code sent to your relative's mobile number",
              style: TextStyle(fontSize: screenHeight * 0.015),
              textAlign: TextAlign.center,
            )),
        SizedBox(
          height: screenHeight * 0.03,
        ),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.2),
            child: const OTPInput()),
        SizedBox(
          height: screenHeight * 0.05,
        ),
        TextButton(
          onPressed: () {
            updateUI();
            Navigator.pop(context);
          },
          style: TextButton.styleFrom(
            backgroundColor: const Color(0xFF2980B9),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(screenHeight * 0.05),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
            child: Text(
              "Add",
              style: TextStyle(
                color: Colors.white,
                fontSize: screenHeight * 0.018,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class Input extends StatelessWidget {
  final String label;
  final TextEditingController controller;

  const Input({Key? key, required this.label, required this.controller})
      : super(key: key);

  // String? _validateInput(String? value) {
  //   if (value == null || value.isEmpty) {
  //     return 'Please enter a title';
  //   }
  //   return null;
  // }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.15, vertical: screenHeight * 0.008),
      child: TextFormField(
        controller: controller,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        // validator: _validateInput,
        decoration: InputDecoration(
          labelText: label,
          contentPadding: EdgeInsets.only(left: screenWidth * 0.05),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
      ),
    );
  }
}
