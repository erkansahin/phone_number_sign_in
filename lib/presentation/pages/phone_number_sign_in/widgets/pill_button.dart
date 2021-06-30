import 'package:flutter/material.dart';

import 'gradient_container.dart';

class PillButton extends StatelessWidget {
  final String text;
  final GestureTapCallback onTap;
  final double height;
  final double width;
  //final double borderRadiusLength;
  final BoxShadow? buttonShadow;
  final TextStyle textStyle;
  final List<Color> buttonGradient;
  final List<Color> textGradient;

  const PillButton(
      {required this.onTap,
      required this.text,
      required this.height,
      required this.width,
      this.buttonShadow,
      required this.textStyle,
      required this.buttonGradient,
      required this.textGradient});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        boxShadow: [
          buttonShadow ??
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 4.0,
                offset: const Offset(
                  0,
                  3,
                ),
              ),
        ],
        borderRadius: BorderRadius.all(Radius.circular(height / 2.0)),
        color: buttonGradient.first,
        gradient: buttonGradient.length > 1
            ? LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  ...buttonGradient,
                ],
              )
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.all(Radius.circular(height / 2.0)),
        child: InkWell(
          borderRadius: BorderRadius.all(Radius.circular(height / 2.0)),
          onTap: () {
            onTap();
          },
          child: Center(
            child: textGradient.length > 1
                ? GradientContainer(
                    gradientColors: [
                      ...textGradient,
                    ],
                    child: Text(
                      text,
                      style: const TextStyle(
                        fontSize: 13,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  )
                : Text(
                    text,
                    style: TextStyle(
                      fontSize: 13,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold,
                      color: textGradient.first,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
