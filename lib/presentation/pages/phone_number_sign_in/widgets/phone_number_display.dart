import 'package:flutter/material.dart';

import '../constants/constants.dart';
import 'gradient_text.dart';

class PhoneNumberDisplay extends StatelessWidget {
  final String phoneNumber;

  const PhoneNumberDisplay({
    required this.phoneNumber,
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
      child: Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        child: GradientText(
          "You are signed in with: \n $phoneNumber",
          gradientColors: const [topGradientColor, bottomGradientColor],
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
