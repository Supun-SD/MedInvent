import 'package:flutter/material.dart';

class Inputbutton extends StatelessWidget {
  const Inputbutton({
    super.key,
    required this.topic,
    this.tvalue = 0.0,
    this.bvalue = 0.0,
    this.lvalue = 0.0,
    this.rvalue = 0.0,
    this.wiht = 0.0,
  });

  final String topic;
  final double tvalue;
  final double bvalue;
  final double lvalue;
  final double rvalue;
  final double wiht;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          top: tvalue, bottom: bvalue, left: lvalue, right: rvalue),
      width: wiht, // Adjust the margin as needed
      child: TextField(
        decoration: InputDecoration(
          labelText: topic,
          contentPadding: const EdgeInsets.all(16.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40.0),
          ),
        ),
      ),
    );
  }
}
