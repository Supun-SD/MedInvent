import 'package:flutter/material.dart';

class UserDetail extends StatelessWidget {
  final String text;
  const UserDetail({required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      child: Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 15),
        decoration: BoxDecoration(
          color: const Color(0xffeeeeee),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Text(text),
      ),
    );
  }
}
