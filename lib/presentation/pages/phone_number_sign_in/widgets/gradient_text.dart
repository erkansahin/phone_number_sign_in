import 'package:flutter/material.dart';

import 'gradient_container.dart';

class GradientText extends StatelessWidget {
  final TextStyle? style;
  final List<Color> gradientColors;
  final String text;
  final TextAlign textAlign;
  const GradientText(
    this.text, {
    required this.gradientColors,
    this.style,
    this.textAlign = TextAlign.center,
  });
  @override
  Widget build(BuildContext context) {
    return GradientContainer(
      gradientColors: gradientColors,
      child: Text(
        text,
        textAlign: textAlign,
        style: style?.merge(
          const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
