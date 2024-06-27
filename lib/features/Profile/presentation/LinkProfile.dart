import 'package:MedInvent/components/otp_input.dart';
import 'package:flutter/material.dart';
import 'package:MedInvent/features/Profile/services/dependent_service.dart';
import 'package:MedInvent/features/Profile/models/linkUser.dart';
import 'dart:convert';

class DependProvider extends InheritedWidget {
  final LinkUser? newDepend;

  const DependProvider(
      {Key? key, required Widget child, required this.newDepend})
      : super(key: key, child: child);

  static DependProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<DependProvider>();
  }

  @override
  bool updateShouldNotify(DependProvider oldWidget) {
    return oldWidget.newDepend != newDepend;
  }
}

class AddExistingMember extends StatefulWidget {
  const AddExistingMember({super.key});

  @override
  State<AddExistingMember> createState() => _AddExistingMemberState();
}

class _AddExistingMemberState extends State<AddExistingMember> {
  final PageController _pageController = PageController(initialPage: 0);
  LinkUser? newDepend;

  void setNewDepend(LinkUser depend) {
    setState(() {
      newDepend = depend;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    return DependProvider(
      newDepend: newDepend,
      child: SizedBox(
        height: screenHeight * 0.5 + keyboardSpace,
        child: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            LinkProfile(
              pageController: _pageController,
              setNewDepend: setNewDepend,
            ),
            OtpVerify(pageController: _pageController),
          ],
        ),
      ),
    );
  }
}

class LinkProfile extends StatefulWidget {
  final PageController pageController;
  final void Function(LinkUser) setNewDepend;

  const LinkProfile(
      {super.key, required this.pageController, required this.setNewDepend});

  @override
  State<LinkProfile> createState() => _LinkProfileState();
}

class _LinkProfileState extends State<LinkProfile> {
  TextEditingController relationship = TextEditingController();
  TextEditingController mobileNo = TextEditingController();
  TextEditingController nic = TextEditingController();

  String? relationshipError;
  String? mobileNoError;
  String? nicError;

  Future<bool> checkUserAvailabe() async {
    LinkUser newDepend = LinkUser(
      mobileNo.text,
      "",
      nic.text,
      relationship.text,
    );
    try {
      BaseClient baseClient = BaseClient();
      var response = await baseClient.postCheckuserdata(
          '/Notification/check/user/available', newDepend.toRawJson());
      if (response != null) {
        // Handle successful response
        //print(response);
        Map<String, dynamic> decodedJson = json.decode(response);
        newDepend.receiverID = decodedJson['data']['userID'];
        //print(newDepend.receiverID);
        if (newDepend.receiverID != null) {
          baseClient = BaseClient();
          var response = await baseClient.post(
              '/Notification/get/tokens/to/send/OTP',
              newDepend.toRawJsonForSecondRequest());
          if (response != null) {
            Map<String, dynamic> decodedJson = json.decode(response);
            List<dynamic> data = decodedJson['data'];
            for (var item in data) {
              for (var tokenStore in item['TokenStores']) {
                newDepend.FcmTokens.add(tokenStore['fcm_token']);
              }
            }
            if (newDepend.FcmTokens.isNotEmpty) {
              bool B = await newDepend.assignLoggedUserID();
              if (B){
                baseClient = BaseClient();
                var response = await baseClient.post(
                    '/Notification/send/OTP/link/user',
                    newDepend.toRawJsonForThirdRequest());
                if (response == null) {
                  return false;
                }
              } else {
                return false;
              }
            } else {
              return false;
            }
          } else {
            return false;
          }
          //print(response);
        } else {
          return false;
        }
        widget.setNewDepend(newDepend); // Set newDepend
        return true;
      } else {
        return false;
      }
    } catch (e) {
      // Handle error
      print("Error: $e");
      return false;
    }
  }

  void validateInputs() {
    setState(() {
      relationshipError = null;
      mobileNoError = null;
      nicError = null;

      if (!RegExp(r"^[a-zA-Z]+$").hasMatch(relationship.text)) {
        relationshipError = "Relationship cannot contain numbers or symbols.";
      }
      if (!RegExp(r"^[+0-9]+$").hasMatch(mobileNo.text)) {
        mobileNoError = "can only contain numbers.";
      }
      if (!RegExp(r"^[a-zA-Z0-9]+$").hasMatch(nic.text)) {
        nicError = "cannot contain symbols.";
      }
    });
  }

  void showPopupMessage(BuildContext context, String message, Color backgroundColor) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          content: Text(
            message,
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        );
      },
    );
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
        Input(label: "Relationship", controller: relationship, errorText: relationshipError),
        Input(label: "Mobile Number", controller: mobileNo, errorText: mobileNoError),
        Input(label: "NIC", controller: nic,errorText: nicError),
        SizedBox(
          height: screenHeight * 0.02,
        ),
        TextButton(
          onPressed: () async {
            validateInputs();
            if (relationshipError == null && mobileNoError == null && nicError == null) {
                var isAvailable = await checkUserAvailabe();
                if (isAvailable) {
                  showPopupMessage(context, "OTP sent to relevant person", Colors.green); // Success popup
                  widget.pageController.animateToPage(1,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut);
                } else {
                  showPopupMessage(context, "Invalid Details! enter correct details to link", Colors.redAccent); // Error popup
                }
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

class OtpVerify extends StatefulWidget {
  final PageController pageController;

  const OtpVerify({super.key, required this.pageController});

  @override
  State<OtpVerify> createState() => _OtpVerifyState();
}

class _OtpVerifyState extends State<OtpVerify> {
  final List<TextEditingController> controllers =
      List.generate(4, (index) => TextEditingController());

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  String? _getOtp() {
    for (var controller in controllers) {
      if (controller.text.isEmpty) {
        return null;
      }
    }
    String otp = controllers.map((controller) => controller.text).join();
    return otp;
  }

  Future<bool> addProcess(LinkUser newDepend) async {
    try {
      BaseClient baseClient = BaseClient();
      print(newDepend.FcmToken);
      print(newDepend.OTPNumber);
      print(newDepend.LoggedUserID);
      print(newDepend.receiverNic);
      var response = await baseClient.post(
          '/Notification/check/OTP', newDepend.toRawJsonForFourthRequest());
      if (response != null) {
        Map<String, dynamic> decodedJson = json.decode(response);
        print(response);
        bool isCorrectotp = decodedJson['data'];
        print(isCorrectotp);
        if (isCorrectotp) {
          print("is_correctOTP $isCorrectotp");
          baseClient = BaseClient();
          // print(newDepend.toJsonForFifthRequest());
          print("before request send");
          var response = await baseClient.post(
              '/DependMember/add/new/linked/DependMember',
              newDepend.toRawJsonForFifthRequest());
          if (response != null) {
            Map<String, dynamic> decodedJson = json.decode(response);
            String data = decodedJson['data']['dID'];
            // ignore: unnecessary_null_comparison
            if (data != null) {
              return true;
            } else {
              print("data null");
              return false;
            }
          } else {
            print("response null");
            return false;
          }
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      // Handle error
      print("Error: $e");
      return false;
    }
  }

  void showPopupMessage(BuildContext context, String message, Color backgroundColor) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          content: Text(
            message,
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final newDepend = DependProvider.of(context)?.newDepend;

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
            child: OTPInput(
              controllers: controllers,
            )),
        SizedBox(
          height: screenHeight * 0.05,
        ),
        TextButton(
          onPressed: () async {
            if (newDepend != null) {
              var getOTPValue = _getOtp();
              if (getOTPValue != null) {
                newDepend.OTPNumber = int.parse(getOTPValue);
                var addNewDependdata = await addProcess(newDepend);
                if (addNewDependdata) {
                  showPopupMessage(context, "Linked Successfully", Colors.green); // Success popup
                  print("process success");
                } else {
                  showPopupMessage(context, "Invalid OTP", Colors.redAccent); // Error popup
                  print("invalid OTP");
                }
              } else {
                showPopupMessage(context, "Enter received OTP to proceed", Colors.redAccent); // Error popup
                print("OTP is null");
              }
            } else {
              showPopupMessage(context, "process failed", Colors.redAccent); // Error popup
              print("null new depend");
            }
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
  final String? errorText;

  const Input({Key? key, required this.label, required this.controller,this.errorText})
      : super(key: key);

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
        decoration: InputDecoration(
          labelText: label,
          errorText: errorText,
          contentPadding: EdgeInsets.only(left: screenWidth * 0.05),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
      ),
    );
  }
}
