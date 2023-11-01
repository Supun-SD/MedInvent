import 'package:flutter/material.dart';
import './language_selection.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: const EdgeInsets.fromLTRB(70, 0, 70, 0),
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 300,
              left: 0,
              right: 0,
              child: Image.asset('assets/images/logo.png'),
            ),
            const Positioned(
              bottom: 150,
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  'Swipe to begin',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
