import 'package:auto_route/auto_route.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

import '../../../application/auth/auth_cubit.dart';
import '../../../application/auth/phone_number_sign_in/phone_number_sign_in_cubit.dart';
import '../../../injection.dart';
import '../../routes/router.gr.dart';
import 'constants/constants.dart';
import 'widgets/auth_text_button.dart';
import 'widgets/jumping_dots_loading_indicator.dart';
import 'widgets/phone_number_form.dart';
import 'widgets/sms_code_form.dart';
import 'widgets/sponty_auth_logo.dart';

class PhoneNumberSignInPage extends StatefulWidget {
  const PhoneNumberSignInPage({Key? key}) : super(key: key);

  @override
  _PhoneNumberSignInPageState createState() => _PhoneNumberSignInPageState();
}

class _PhoneNumberSignInPageState extends State<PhoneNumberSignInPage> {
  static const int smsTimeoutInSeconds = 120;

  final GlobalKey<FormState> _phoneFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<PhoneNumberSignInCubit>(),
      child: MultiBlocListener(
        listeners: [
          BlocListener<AuthCubit, AuthState>(
            listenWhen: (p, c) => p.isLoggedIn != c.isLoggedIn && c.isLoggedIn,
            listener: (context, state) {
              AutoRouter.of(context).replace(
                const HomeRoute(),
              );
            },
          ),
          BlocListener<PhoneNumberSignInCubit, PhoneNumberSignInState>(
            listenWhen: (p, c) => p.failureOption != c.failureOption,
            listener: (context, state) {
              state.failureOption.fold(() {}, (failure) {
                BotToast.showText(
                  text: failure.when(
                      serverError: () => "Server Error",
                      invalidPhoneNumber: () => "Invalid Phone Number",
                      tooManyRequests: () => "Too Many Requests",
                      deviceNotSupported: () => "Device Not Supported",
                      smsTimeout: () => "Sms Timeout",
                      sessionExpired: () => "Session Expired",
                      invalidVerificationCode: () =>
                          "Invalid Verification Code"),
                );

                context.read<PhoneNumberSignInCubit>().reset();
              });
            },
          ),
        ],
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                topGradientColor,
                bottomGradientColor,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SafeArea(
              child: KeyboardVisibilityBuilder(
                builder: (BuildContext context, bool isKeyboardVisible) {
                  final Size size = MediaQuery.of(context).size;
                  return SingleChildScrollView(
                    physics: isKeyboardVisible
                        ? const BouncingScrollPhysics()
                        : const NeverScrollableScrollPhysics(),
                    child: SizedBox(
                      height: size.height,
                      width: size.width,
                      child: BlocBuilder<PhoneNumberSignInCubit,
                          PhoneNumberSignInState>(
                        builder: (BuildContext context,
                            PhoneNumberSignInState phoneNumberSignInState) {
                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 83.0),
                                child: AuthLogo(),
                              ),
                              if (phoneNumberSignInState.displaySmsCodeForm)
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.bottomCenter,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: SMSCodeForm(
                                            phoneNumber: phoneNumberSignInState
                                                .phoneNumber,
                                            onChanged: (val) {
                                              context
                                                  .read<
                                                      PhoneNumberSignInCubit>()
                                                  .smsCodeChanged(
                                                      smsCode: val ?? "");
                                            },
                                            onCompleted: (val) {
                                              context
                                                  .read<
                                                      PhoneNumberSignInCubit>()
                                                  .verifySmsCode();
                                            },
                                            onTimerCompleted: () {
                                              BotToast.showText(
                                                  text: "SMS Code Timeout!");
                                              context
                                                  .read<
                                                      PhoneNumberSignInCubit>()
                                                  .reset();
                                            },
                                            smsCodeTimeoutSeconds:
                                                smsTimeoutInSeconds,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              else
                                Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 8, 20, 0),
                                  child: Column(
                                    children: [
                                      PhoneNumberForm(
                                        formKey: _phoneFormKey,
                                        onInputChanged: (val) => context
                                            .read<PhoneNumberSignInCubit>()
                                            .phoneNumberChanged(
                                              phoneNumber: val ?? "",
                                            ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 16),
                                        child: Align(
                                          alignment: Alignment.topRight,
                                          child: phoneNumberSignInState
                                                  .displayNextButton
                                              ? AuthTextButton(
                                                  text: "Next",
                                                  onPressed: () {
                                                    if (_phoneFormKey
                                                                .currentState !=
                                                            null &&
                                                        _phoneFormKey
                                                            .currentState!
                                                            .validate()) {
                                                      context
                                                          .read<
                                                              PhoneNumberSignInCubit>()
                                                          .signInWithPhoneNumber();
                                                    }
                                                  },
                                                )
                                              : Container(),
                                        ),
                                      ),
                                      if (phoneNumberSignInState.isInProgress)
                                        const JumpingDotsLoadingIndicator(
                                          color: Colors.white,
                                        )
                                    ],
                                  ),
                                ),
                            ],
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
