import 'package:flutter/material.dart';
import 'package:todo_app/core/res/colours.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton(
      {super.key,
      required this.label,
      required this.onPressed,
      this.buttonColor,
      this.labelColor});

  final String label;
  final VoidCallback onPressed;
  final Color? buttonColor;
  final Color? labelColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor ?? Colours.primaryColor,
        foregroundColor: labelColor ?? Colors.white,
        minimumSize: const Size(double.maxFinite, 50),
      ),
      child:  Text(label),
    );
  }
}
