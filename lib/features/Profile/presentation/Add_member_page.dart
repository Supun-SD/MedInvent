import 'package:MedInvent/features/Profile/presentation/family_members_page.dart';
import 'package:flutter/material.dart';
import 'package:MedInvent/components/input_field_edit.dart';
import 'package:MedInvent/components/BottomNavBar.dart';

class AddMember extends StatefulWidget {
  const AddMember({super.key});

  @override
  State<AddMember> createState() => AddMemberState();
}

class AddMemberState extends State<AddMember> {
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
              title: const Text("Add member"),
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
                    Container(
                      margin: const EdgeInsets.only(top: 25.0),
                      width: 356,
                      height: 490,
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
                            topic: 'Relationship',
                            tvalue: 33,
                            bvalue: 24,
                            wiht: 300,
                          ),
                          Inputbutton(
                            topic: 'First Name',
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
                    AddButton(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const FamilyMembers()),
                        );
                      },
                      save: 'Add',
                    ),
                    SizedBox(height: screenHeight * 0.07,)
                  ],
                ),
              ),
            ),
          ),
          const Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: BottomNavBar(),
          ),
        ],
      ),
    );
  }
}

// class AddMember extends StatelessWidget {
//   const AddMember({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.topRight,
//             colors: [
//               Color(0xFF474CA0),
//               Color(0xFF468FA0),
//             ],
//           ),
//         ),
//         child: Align(
//             alignment: Alignment.bottomCenter,
//             child: Container(
//               margin: const EdgeInsets.only(top: 100.0),
//               padding: const EdgeInsets.only(top: 5.0),
//               height: 750,
//               width: MediaQuery.of(context).size.width,
//               decoration: const BoxDecoration(
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(50),
//                   topRight: Radius.circular(50),
//                 ),
//                 color: Colors.white,
//               ),
//
//             )),
//       ),
//       bottomNavigationBar: const BottomNavBar(),
//     );
//   }
// }
class AddButton extends StatelessWidget {
  const AddButton({
    super.key,
    required this.onTap,
    required this.save,
  });
  final String save;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12.0),
        width: 135,
        alignment: Alignment.center,
        margin: const EdgeInsets.only(top: 30.0,bottom: 50),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
          color: Color(0xFF2980B9),
        ),
        child: Text(
          save,
          style: const TextStyle(
            fontSize: 15,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
