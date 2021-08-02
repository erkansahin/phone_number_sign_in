import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../constants/constants.dart';
import 'countdown_timer.dart';
import 'gradient_text.dart';

class SMSCodeForm extends StatelessWidget {
  final String phoneNumber;

  ///The callback called when the SMS code form has changed.
  final void Function(String?) onChanged;

  ///The callback called when the timer is completed.
  final void Function() onTimerCompleted;

  ///The total amount of seconds until the SMS code will timeout.
  final int smsCodeTimeoutSeconds;

  const SMSCodeForm({
    required this.phoneNumber,
    required this.onChanged,
    required this.onTimerCompleted,
    required this.smsCodeTimeoutSeconds,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController smsController = TextEditingController();
    final Size size = MediaQuery.of(context).size;

    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(30), topLeft: Radius.circular(30)),
        color: Colors.white,
      ),
      padding: EdgeInsets.fromLTRB(
          0, 24, 0, MediaQuery.of(context).viewPadding.bottom),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
              alignment: Alignment.centerLeft,
              child: const GradientText(
                "Verification Code",
                gradientColors: [topGradientColor, bottomGradientColor],
                style: TextStyle(fontSize: 22),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              alignment: Alignment.centerLeft,
              child: Text(
                "Please type the verification code sent to $phoneNumber",
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
              child: PinCodeTextField(
                keyboardType: TextInputType.phone,
                autoFocus: true,
                length: 6,
                animationType: AnimationType.fade,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(8),
                  fieldHeight: 48,
                  fieldWidth: 40,
                  activeColor: Colors.grey.shade300,
                  inactiveFillColor: Colors.grey.shade400,
                  inactiveColor: Colors.grey.shade400,
                  activeFillColor: Colors.grey.shade400,
                ),
                animationDuration: const Duration(milliseconds: 300),
                backgroundColor: Colors.transparent,
                controller: smsController,
                appContext: context,
                onChanged: onChanged,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
              child: Row(
                children: [
                  const Spacer(),
                  CountDownTimer(
                    smsCodeTimeoutSeconds: smsCodeTimeoutSeconds,
                    onTimerCompleted: onTimerCompleted,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Image.asset(
                "assets/images/sms.png",
                width: size.width,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
