import 'package:flutter/material.dart';

class RadioButtonOption extends StatelessWidget {
  final String text;
  final String groupValue;
  final String value;
  final ValueChanged<String?> onChanged;

  RadioButtonOption({
    required this.text,
    required this.groupValue,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          onChanged(value);
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Radio<String>(
                value: value,
                groupValue: groupValue,
                onChanged: onChanged,
              ),
              Text(text),
            ],
          ),
        ),
      ),
    );
  }
}
