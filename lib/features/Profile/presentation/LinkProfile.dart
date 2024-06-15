import 'package:MedInvent/components/otp_input.dart';
import 'package:flutter/material.dart';
import 'package:MedInvent/features/Profile/services/dependent_service.dart';
import 'package:MedInvent/features/Profile/data/models/linkUser.dart';
import 'dart:convert';

class AddExistingMember extends StatefulWidget {
  const AddExistingMember({super.key});

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
      height: screenHeight * 0.5 + keyboardSpace,
      child: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            LinkProfile(
              pageController: _pageController,
            ),
            OtpVerify(pageController: _pageController),
          ]),
    );
  }
}

class LinkProfile extends StatefulWidget {
  final PageController pageController;

  LinkProfile({super.key, required this.pageController});

  @override
  State<LinkProfile> createState() => _LinkProfileState();
}

class _LinkProfileState extends State<LinkProfile> {
  TextEditingController relationship = TextEditingController();

  TextEditingController mobileNo = TextEditingController();

  TextEditingController nic = TextEditingController();


  Future<bool> checkUserAvailabe() async {
     LinkUser newDepend = LinkUser(
        mobileNo.text,
        "",
        nic.text,
        relationship.text,
      );
      // Send the new member data to the backend
      try {
        BaseClient baseClient = BaseClient();
        var response = await baseClient.postCheckuserdata(
          '/Notification/check/user/available',
          newDepend.toRawJson()
        );
        if (response != null) {
          // Handle successful response
          //print(response);
          Map<String, dynamic> decodedJson  = json.decode(response);
          newDepend.receiverID=decodedJson ['data']['userID'];
          //print(newDepend.receiverID);
          if(newDepend.receiverID != null) {
              baseClient = BaseClient();
              var response = await baseClient.post(
                  '/Notification/get/tokens/to/send/OTP',
                  newDepend.toRawJsonForSecondRequest()
              );
              if(response != null) {
                 Map<String, dynamic> decodedJson = json.decode(response);
                 List<dynamic> data = decodedJson['data'];

                 for (var item in data) {
                   for (var tokenStore in item['TokenStores']) {
                     newDepend.FcmTokens.add(tokenStore['fcm_token']);
                   }
                 }
                 if(newDepend.FcmTokens.length>0) {
                     bool A =await newDepend.temporary();
                     bool B =await newDepend.assignLoggedUserID();
                     if(A && B)
                       {
                           baseClient = BaseClient();
                           var response = await baseClient.post(
                               '/Notification/send/OTP/link/user',
                               newDepend.toRawJsonForThirdRequest()
                           );
                           if(response==null)
                           {
                               return false;
                           }
                       }
                     else{
                       return false;
                     }
                 }
                 else{
                   return false;
                 }

              }
              else{
                return false;
              }
              //print(response);
          }
          else{
            return false;
          }
          return true;
        }
        else{
          return false;
        }
      } catch (e) {
        // Handle error
        print("Error: $e");
        return false;
      }
     return false;
  }

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
          onPressed: () async{
            //have to do validation before send backend
            var is_available = await checkUserAvailabe();
            if(is_available)
              {
                widget.pageController.animateToPage(2,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut);
              }
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

  const OtpVerify({super.key, required this.pageController});
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
              "Enter the confirmation code sent to your relative's mobile device",
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
