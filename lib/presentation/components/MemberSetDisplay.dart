import 'package:flutter/material.dart';

class MemberDisplay extends StatelessWidget {
  const MemberDisplay({
    super.key,
    required this.iconprofile,
    required this.buttonTextMain1,
    required this.buttonTextMain2,
    required this.iconDiamond,
    required this.number,
  });

  final IconData iconprofile;
  final String buttonTextMain1;
  final String buttonTextMain2;
  final IconData iconDiamond;
  final String number;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        height:80,
        width: 100,
        //width:310,
        margin: const EdgeInsets.only(top: 20.0,left: 5,right: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          color: Colors.white,
          /*border: Border.all(
            color: Colors.black,
            width: 2.0,
          ),*/
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10.0,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ClipOval(
                child: Image.asset(
                  'assets/images/pic.png',
                  width: 54.0,
                  height: 54.0,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              height: 46,
              width: 170,
              margin: const EdgeInsets.only(left: 15.0, right: 40.0,top: 10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      buttonTextMain1,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      buttonTextMain2,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black45,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ]),
            ),
            Icon(
              iconDiamond,
              color: Colors.red,
            ),
            Text(
              number,
            ),
          ],
        ),
      ),
    );
  }
}