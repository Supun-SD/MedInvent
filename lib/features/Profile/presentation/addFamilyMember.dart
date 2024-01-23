import 'package:MedInvent/features/Profile/presentation/LinkProfile.dart';
import 'package:MedInvent/features/Profile/presentation/createLocalProfile.dart';
import 'package:flutter/material.dart';

class AddNewMember extends StatelessWidget {
  const AddNewMember({super.key, required this.updateUI});

  final VoidCallback updateUI;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: screenHeight * 0.04,
        ),
        Text(
          "Add a family member",
          style: TextStyle(
              fontSize: screenHeight * 0.02, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: screenHeight * 0.05,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Link Profile",
                  style: TextStyle(fontSize: screenHeight * 0.018),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(screenHeight * 0.015),
                    ),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                        showModalBottomSheet(
                          isScrollControlled: true,
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(screenHeight * 0.05)),
                          ),
                          context: context,
                          builder: (BuildContext context) {
                            return AddExistingMember(updateUI : updateUI);
                          },
                        );
                      },
                      icon: const Icon(
                        Icons.link_rounded,
                      ),
                    ),
                  ),
                ),
                Text(
                  "Link an existing profile",
                  style: TextStyle(fontSize: screenHeight * 0.013),
                )
              ],
            ),
            SizedBox(
              width: screenWidth * 0.1,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "New profile",
                  style: TextStyle(fontSize: screenHeight * 0.018),
                ),
                Padding(
                    padding:
                    EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                        borderRadius:
                        BorderRadius.circular(screenHeight * 0.015),
                      ),
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                          showModalBottomSheet(
                            isScrollControlled: true,
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(screenHeight * 0.05)),
                            ),
                            context: context,
                            builder: (BuildContext context) {
                              return CreateLocalProfile(updateUI : updateUI);
                            },
                          );
                        },
                        icon: const Icon(
                          Icons.person_add_alt_1,
                        ),
                      ),
                    )),
                Text(
                  "Create a local account",
                  style: TextStyle(fontSize: screenHeight * 0.013),
                )
              ],
            ),
          ],
        ),
        SizedBox(
          height: screenHeight * 0.07,
        ),
      ],
    );
  }
}




