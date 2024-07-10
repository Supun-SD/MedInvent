import 'package:MedInvent/features/login/models/user_model.dart';
import 'package:MedInvent/features/prescriptions/model/DependMember.dart';
import 'package:MedInvent/features/prescriptions/model/NewPrescription.dart';
import 'package:MedInvent/features/prescriptions/model/Prescription.dart';
import 'package:MedInvent/features/prescriptions/presentation/newPrescription.dart';
import 'package:MedInvent/features/prescriptions/presentation/prescriptionDetails.dart';
import 'package:MedInvent/providers/authProvider.dart';
import 'package:MedInvent/providers/dependMemberProvider.dart';
import 'package:MedInvent/providers/prescriptionsProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

//Widget to display individual prescription details
class PrescriptionTemplate extends ConsumerStatefulWidget {
  final Prescription p;

  const PrescriptionTemplate({super.key, required this.p});

  @override
  ConsumerState<PrescriptionTemplate> createState() =>
      _PrescriptionTemplateState();
}

// State class for DocPrescriptionTemplate
class _PrescriptionTemplateState extends ConsumerState<PrescriptionTemplate> {
  String profilePicture = "assets/images/pic.png";

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    User user = ref.watch(userProvider).user!;

    return Container(
      margin: EdgeInsets.only(bottom: screenHeight * 0.025),
      width: screenWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(screenHeight * 0.05),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 50.0,
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.07, vertical: screenHeight * 0.015),
        child: Column(
          children: [
            // Display assigned member information or assign button
            if (widget.p.assignedTo == null)
              Row(
                children: [
                  Text(
                    "Not Assigned",
                    style: TextStyle(fontSize: screenHeight * 0.017),
                  ),
                  const Spacer(),
                  // Button to assign prescription
                  TextButton(
                    onPressed: () {
                      showModalBottomSheet(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                              top: Radius.circular(screenHeight * 0.05)),
                        ),
                        context: context,
                        builder: (BuildContext context) {
                          return AssignPrescription(
                            prescription: widget.p,
                            isNewPres: false,
                          );
                        },
                      );
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: const Color(0xFF2980B9),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(screenHeight * 0.05),
                      ),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                      child: Text(
                        "Assign",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: screenHeight * 0.015),
                      ),
                    ),
                  ),
                ],
              )
            else
              (widget.p.assignedTo == 'user')
                  ? Padding(
                      padding: EdgeInsets.only(
                          top: screenHeight * 0.01,
                          bottom: screenHeight * 0.02),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: AssetImage(profilePicture),
                            radius: screenHeight * 0.025,
                          ),
                          SizedBox(
                            width: screenWidth * 0.05,
                          ),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${user.fname} ${user.lname}",
                                  style: TextStyle(
                                      fontSize: screenHeight * 0.02,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: screenHeight * 0.005,
                                ),
                                Text(
                                  "You",
                                  style:
                                      TextStyle(fontSize: screenHeight * 0.015),
                                ),
                              ]),
                        ],
                      ),
                    )
                  : Padding(
                      padding: EdgeInsets.only(
                          top: screenHeight * 0.01,
                          bottom: screenHeight * 0.02),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: AssetImage(profilePicture),
                            radius: screenHeight * 0.025,
                          ),
                          SizedBox(
                            width: screenWidth * 0.05,
                          ),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${widget.p.dependMember!.fname} ${widget.p.dependMember!.lname}",
                                  style: TextStyle(
                                      fontSize: screenHeight * 0.02,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: screenHeight * 0.005,
                                ),
                                Text(
                                  widget.p.dependMember!.relationship,
                                  style:
                                      TextStyle(fontSize: screenHeight * 0.015),
                                ),
                              ]),
                        ],
                      ),
                    ),

            // Display prescription title, date issued, doctor, and more details button
            Row(children: [
              Text(
                widget.p.presName,
                style: TextStyle(
                    fontSize: screenHeight * 0.02, fontWeight: FontWeight.bold),
              )
            ]),
            SizedBox(
              height: screenHeight * 0.02,
            ),

            // Display date issued
            Row(
              children: [
                SizedBox(
                  width: screenWidth * 0.35,
                  child: Row(
                    children: [
                      Icon(
                        Icons.calendar_month,
                        size: screenWidth * 0.045,
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        widget.p.createdBy == "doctor"
                            ? "Date issued"
                            : "Date created",
                        style: TextStyle(fontSize: screenWidth * 0.035),
                      )
                    ],
                  ),
                ),
                Text(
                  widget.p.createdAt.split('T')[0],
                  style: TextStyle(
                      fontSize: screenWidth * 0.035,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),

            // Display doctor
            SizedBox(
              height: screenHeight * 0.015,
            ),
            if (widget.p.createdBy == "doctor")
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: screenWidth * 0.35,
                    child: Row(
                      children: [
                        Icon(
                          Icons.account_circle_outlined,
                          size: screenWidth * 0.045,
                          color: Colors.grey,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Doctor",
                          style: TextStyle(fontSize: screenWidth * 0.035),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Text(
                      widget.p.doctorName!,
                      style: TextStyle(
                          fontSize: screenWidth * 0.035,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),

            SizedBox(
              height: screenHeight * 0.02,
            ),

            // Button to navigate to prescription details screen
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PrescriptionDetails(
                                prescription: widget.p,
                              )),
                    );
                  },
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(screenHeight * 0.05),
                      side: const BorderSide(color: Color(0xFF2980B9)),
                    ),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                    child: Text(
                      "More details",
                      style: TextStyle(
                          color: const Color(0xFF2980B9),
                          fontSize: screenHeight * 0.015),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

// Widget for assigning prescriptions to profiles
class AssignPrescription extends ConsumerStatefulWidget {
  final Prescription? prescription;
  final bool isNewPres;

  const AssignPrescription({
    super.key,
    required this.prescription,
    required this.isNewPres,
  });

  @override
  ConsumerState<AssignPrescription> createState() => AssignPrescriptionState();
}

// State class for AssignPrescription
class AssignPrescriptionState extends ConsumerState<AssignPrescription> {
  var selectedProfile;

  void onAssignPress() {
    DependMember? selectedMember;
    String? assignedTo;
    if (selectedProfile is DependMember) {
      selectedMember = selectedProfile;
      assignedTo = 'dependMember';
    } else {
      selectedMember = null;
      assignedTo = 'user';
    }

    ref.read(prescriptionsProvider.notifier).assignPrescription(
        widget.prescription!, assignedTo, selectedMember, context);
  }

  void onNextPress() {
    DependMember? selectedMember;
    String? assignedTo;
    String? dID;
    if (selectedProfile is DependMember) {
      selectedMember = selectedProfile;
      assignedTo = 'dependMember';
      dID = selectedMember!.dID;
    } else if(selectedProfile == 'me'){
      selectedMember = null;
      assignedTo = 'user';
      dID = null;
    }
    NewPrescription newPres = NewPrescription();
    newPres.assignedTo = assignedTo;
    newPres.dependMember = selectedMember;
    newPres.presMedicine = [];
    newPres.dID = dID;
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => AddNewPrescription(newPrescription: newPres)),
    );
  }

  void onButtonPress() {
    if (selectedProfile == null) {
      return;
    }

    if (widget.isNewPres) {
      onNextPress();
    } else {
      onAssignPress();
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    List<DependMember> dependMembers =
        ref.watch(dependMembersProvider).dependMembers;

    bool isDmLoading = ref.watch(dependMembersProvider).isLoading;
    bool isAssigningLoading = ref.watch(prescriptionsProvider).isLoading;

    return Container(
      padding: EdgeInsets.all(screenWidth * 0.1),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            'Assign the prescription',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: screenHeight * 0.02,
            ),
          ),
          SizedBox(height: screenHeight * 0.025),
          Text(
            'Select the Patient’s Profile to assign this prescription',
            style: TextStyle(
              fontSize: screenHeight * 0.018,
            ),
          ),
          SizedBox(height: screenHeight * 0.025),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: isDmLoading
                ? const Padding(
                    padding: EdgeInsets.symmetric(vertical: 30),
                    child: SpinKitCircle(
                      size: 30,
                      color: Colors.blue,
                    ),
                  )
                : Row(children: [
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedProfile = 'me';
                          });
                        },
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: selectedProfile == 'me'
                                      ? Colors.blue
                                      : Colors.transparent,
                                  width: screenHeight * 0.0025,
                                ),
                              ),
                              child: CircleAvatar(
                                radius: screenHeight * 0.04,
                                backgroundColor: selectedProfile == 'me'
                                    ? Colors.white
                                    : Colors.white,
                                child: Padding(
                                  padding: EdgeInsets.all(screenHeight * 0.005),
                                  child: Image.asset("assets/images/pic.png"),
                                ),
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.01),
                            Text(
                              "Me",
                              style: TextStyle(
                                fontSize: screenHeight * 0.014,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    ...dependMembers.map((selected) {
                      return Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.02),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedProfile = selected;
                            });
                          },
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: selected == selectedProfile
                                        ? Colors.blue
                                        : Colors.transparent,
                                    width: screenHeight * 0.0025,
                                  ),
                                ),
                                child: CircleAvatar(
                                  radius: screenHeight * 0.04,
                                  backgroundColor: selected == selectedProfile
                                      ? Colors.white
                                      : Colors.white,
                                  child: Padding(
                                    padding:
                                        EdgeInsets.all(screenHeight * 0.005),
                                    child: Image.asset("assets/images/pic.png"),
                                  ),
                                ),
                              ),
                              SizedBox(height: screenHeight * 0.01),
                              Text(
                                selected.fname,
                                style: TextStyle(
                                  fontSize: screenHeight * 0.014,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ]),
          ),
          SizedBox(height: screenHeight * 0.02),
          // Button to assign prescription to selected profile
          isAssigningLoading
              ? const SpinKitCircle(
                  size: 35,
                  color: Colors.blue,
                )
              : TextButton(
                  onPressed: onButtonPress,
                  style: TextButton.styleFrom(
                    backgroundColor: const Color(0xFF2980B9),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(screenHeight * 0.05),
                    ),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
                    child: Text(
                      widget.isNewPres ? "Next" : "Assign",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: screenHeight * 0.018,
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
