import 'package:flutter/material.dart';

class AuthLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Image.asset(
            "assets/images/sponty-logo.png",
            width: size.width * 0.2,
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(bottom: 20),
          child: Text(
            "Sponty",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
