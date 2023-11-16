import 'package:MedInvent/features/Profile/presentation/family_members_page.dart';
import 'package:flutter/material.dart';
import 'package:MedInvent/presentation/components/input_field_edit.dart';
import 'package:MedInvent/presentation/components/BottomNavBar.dart';

class AddMember extends StatelessWidget {
  const AddMember({super.key});
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
              padding: const EdgeInsets.only(top: 5.0),
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
                              builder: (context) => const Familymembers()),
                        );
                      },
                      save: 'Add',
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
