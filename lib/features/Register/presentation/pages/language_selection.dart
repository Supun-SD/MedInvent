import 'package:flutter/material.dart';
import 'package:MedInvent/features/login/presentation/pages/login.dart';

class LanguageSelection extends StatelessWidget {
  const LanguageSelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: const EdgeInsets.fromLTRB(70, 0, 70, 0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset('assets/images/logo.png'),
              const SizedBox(
                height: 100,
              ),
              const Text(
                'Select a language to continue',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              languageSelectionButton(context,'English',const LoginPage()),
              languageSelectionButton(context,'සිංහල',const LoginPage()),
              languageSelectionButton(context,'தமிழ்',const LoginPage()),
            ],
          ),
        ),
      ),
    );

  }

  Widget languageSelectionButton(BuildContext context, String text, Widget nav) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
      child: Container(
        width: 225,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: const Color(0xFF2980B9),
        ),
        child: TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => nav),
            );
          },
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
