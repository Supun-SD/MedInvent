import 'package:flutter/material.dart';
import 'package:MedInvent/features/login/presentation/pages/login.dart';
import 'package:go_router/go_router.dart';

class LanguageSelection extends StatelessWidget {
  const LanguageSelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin:
            EdgeInsets.fromLTRB(screenWidth * 0.15, 0, screenWidth * 0.15, 0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset('assets/images/logo.png'),
              SizedBox(
                height: screenHeight * 0.12,
              ),
              Text(
                'Select a language to continue',
                style: TextStyle(
                  fontSize: screenHeight * 0.02,
                ),
              ),
              SizedBox(
                height: screenHeight * 0.05,
              ),
              languageSelectionButton(context, 'English', 'login',
                  false, screenWidth, screenHeight),
              languageSelectionButton(context, 'සිංහල', 'login', true,
                  screenWidth, screenHeight),
              languageSelectionButton(context, 'தமிழ்', 'login', true,
                  screenWidth, screenHeight),
            ],
          ),
        ),
      ),
    );
  }

  Widget languageSelectionButton(BuildContext context, String text, String route,
      bool isDisabled, double screenWidth, double screenHeight) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, screenHeight * 0.02, 0, 0),
      child: Container(
        width: screenWidth * 0.5,
        height: screenHeight * 0.07,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(screenHeight * 0.1),
          color: const Color(0xFF2980B9),
        ),
        child: TextButton(
          onPressed: isDisabled
              ? null
              : () => {GoRouter.of(context).pushNamed(route)},
          child: Text(
            text,
            style: TextStyle(
              fontSize: screenHeight * 0.022,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
