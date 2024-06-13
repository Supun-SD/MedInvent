import 'package:flutter/material.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin:
            EdgeInsets.fromLTRB(screenWidth * 0.15, 0, screenWidth * 0.15, 0),
        child: Stack(
          children: <Widget>[
            Positioned(
              top: screenHeight * 0.35,
              left: 0,
              right: 0,
              child: Image.asset('assets/images/logo.png'),
            ),
            Positioned(
              bottom: screenHeight * 0.17,
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  'Swipe to begin',
                  style: TextStyle(fontSize: screenHeight * 0.02),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
