import 'package:flutter/material.dart';

import '../constants/constants.dart';
import 'gradient_text.dart';

class AuthTextButton extends StatelessWidget {
  final String text;
  final void Function() onPressed;
  const AuthTextButton({
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            blurRadius: 4,
            offset: const Offset(0, 2),
            color: Colors.black.withOpacity(0.08),
          ),
        ],
      ),
      child: Container(
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: TextButton(
            onPressed: onPressed,
            child: GradientText(
              text,
              gradientColors: const [topGradientColor, bottomGradientColor],
              style: const TextStyle(fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }
}
