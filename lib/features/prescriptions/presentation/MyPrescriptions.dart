import 'package:MedInvent/features/Profile/data/datasources/allProfiles.dart';
import 'package:MedInvent/features/Profile/data/models/myProfile.dart';
import 'package:MedInvent/features/prescriptions/model/NewPrescription.dart';
import 'package:MedInvent/features/prescriptions/presentation/PrescriptionTemplate.dart';
import 'package:MedInvent/features/prescriptions/presentation/newPrescription.dart';
import 'package:MedInvent/providers/prescriptionsProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyPresContent extends ConsumerWidget {

  const MyPresContent({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    
    final userPrescriptions = ref.watch(prescriptionsProvider).userPrescriptions;

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.08, vertical: screenHeight * 0.04),
        child: Padding(
          padding: EdgeInsets.only(bottom: screenHeight * 0.1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: userPrescriptions.isEmpty
                    ? [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: screenHeight * 0.1,
                              horizontal: screenWidth * 0.15),
                          child: Text(
                            "You don't have any custom prescriptions",
                            style: TextStyle(
                                fontSize: screenHeight * 0.018,
                                color: Colors.grey),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ]
                    : userPrescriptions.map((e) {
                        return PrescriptionTemplate(p: e);
                      }).toList(),
              ),
              SizedBox(
                height: screenHeight * 0.025,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
                          return const AssignNewPrescription();
                        },
                      );
                    },
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(screenHeight * 0.05),
                        side: const BorderSide(color: Color(0xFF2980B9)),
                      ),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                      child: Text(
                        "Add a new Prescription",
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
      ),
    );
  }
}

// Widget for assigning prescriptions to profiles
class AssignNewPrescription extends ConsumerStatefulWidget {
  const AssignNewPrescription({super.key});

  @override
  ConsumerState<AssignNewPrescription> createState() => AssignNewPrescriptionState();
}

class AssignNewPrescriptionState extends ConsumerState<AssignNewPrescription> {
  var selectedProfile;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

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
            'Select the Patient’s Profile to assign this new prescription',
            style: TextStyle(
              fontSize: screenHeight * 0.018,
            ),
          ),
          SizedBox(height: screenHeight * 0.025),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: allProfiles.map((selected) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
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
                              padding: EdgeInsets.all(screenHeight * 0.005),
                              child: Image.asset("assets/images/pic.png"),
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        selected is MyProfile
                            ? Text(
                                "Myself",
                                style: TextStyle(
                                  fontSize: screenHeight * 0.014,
                                ),
                              )
                            : Text(
                                selected.name.split(" ")[0],
                                style: TextStyle(
                                  fontSize: screenHeight * 0.014,
                                ),
                              ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          SizedBox(height: screenHeight * 0.02),

          // Button to assign prescription to selected profile
          TextButton(
            onPressed: () {
              NewPrescription newPres = NewPrescription();
              newPres.assignedTo = selectedProfile.name;
              newPres.presMedicine = [];
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        AddNewPrescription(newPrescription: newPres)),
              );
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
      ),
    );
  }
}
