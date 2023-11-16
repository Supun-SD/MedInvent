import 'package:MedInvent/features/Profile/presentation/Add_member_page.dart';
import 'package:flutter/material.dart';
import 'package:MedInvent/presentation/components/BottomNavBar.dart';
import 'package:MedInvent/presentation/components/MemberSetDisplay.dart';


class Familymembers extends StatelessWidget {
  const Familymembers({super.key});

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
              //margin: const EdgeInsets.only(top: 100.0),
              height: 500,
              padding: const EdgeInsets.all(20.0),
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  SizedBox(
                    height:340,
                    child: ListView.builder(
                        itemCount: 6,
                        itemBuilder: (context,index){
                          return const MemberDisplay(iconprofile:Icons.man, buttonTextMain1:'Amali Perera ', buttonTextMain2:'Mother', iconDiamond: Icons.diamond, number: '335');
                        }
                    ),
                  ),
                  AddmemberButton(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AddMember()),
                      );
                    },
                    save: 'Add Member',
                  ),
                ],
              ),
            )),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
class AddmemberButton extends StatelessWidget {
  const AddmemberButton({
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
        margin: const EdgeInsets.only(top: 70.0),
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



