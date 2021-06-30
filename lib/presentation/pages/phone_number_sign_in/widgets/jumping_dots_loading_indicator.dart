import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';

import '../constants/constants.dart';
import 'gradient_container.dart';

class JumpingDotsLoadingIndicator extends StatelessWidget {
  final Color? color;
  const JumpingDotsLoadingIndicator({this.color});

  @override
  Widget build(BuildContext context) {
    return GradientContainer(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      gradientColors: color == null
          ? const [
              topGradientColor,
              bottomGradientColor,
            ]
          : [color!, color!],
      child: JumpingDotsProgressIndicator(
        fontSize: 100.0,
        numberOfDots: 5,
        milliseconds: 120,
        color: Colors.white,
      ),
    );
  }
}
