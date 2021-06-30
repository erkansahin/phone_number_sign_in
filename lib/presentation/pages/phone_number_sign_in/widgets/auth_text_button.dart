import 'package:bare_bones/presentation/pages/phone_number_sign_in/constants/constants.dart';
import 'package:flutter/material.dart';

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
            offset: Offset(0, 2),
            color: Colors.black.withOpacity(0.08),
          ),
        ],
      ),
      child: FlatButton(
        padding: const EdgeInsets.symmetric(vertical: 10),
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        onPressed: onPressed,
        child: GradientText(
          text,
          gradientColors: const [topGradientColor, bottomGradientColor],
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
