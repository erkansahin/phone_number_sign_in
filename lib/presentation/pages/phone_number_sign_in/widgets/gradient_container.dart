import 'package:flutter/material.dart';

class GradientContainer extends StatelessWidget {
  final Widget child;
  final List<Color> gradientColors;

  final Alignment begin;
  final Alignment end;

  const GradientContainer({
    required this.gradientColors,
    required this.child,
    this.begin = Alignment.topCenter,
    this.end = Alignment.bottomCenter,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => LinearGradient(
        begin: begin,
        end: end,
        colors: gradientColors,
        tileMode: TileMode.mirror,
      ).createShader(bounds),
      child: child,
    );
  }
}
