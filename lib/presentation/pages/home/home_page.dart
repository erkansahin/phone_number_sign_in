import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/auth/auth_cubit.dart';
import '../../routes/router.gr.dart';
import '../phone_number_sign_in/constants/constants.dart';
import '../phone_number_sign_in/widgets/auth_text_button.dart';
import '../phone_number_sign_in/widgets/phone_number_display.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (p, c) => p.isLoggedIn != c.isLoggedIn && !c.isLoggedIn,
      listener: (context, state) {
        AutoRouter.of(context).navigate(const PhoneNumberSignInRoute());
      },
      child: WillPopScope(
        onWillPop: () => Future<bool>.value(false),
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
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Builder(builder: (context) {
                    final String phoneNumber = context.select(
                        (AuthCubit cubit) => cubit.state.userModel.phoneNumber);
                    return PhoneNumberDisplay(
                      phoneNumber: phoneNumber,
                    );
                  }),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: AuthTextButton(
                        text: "Logout",
                        onPressed: () {
                          context.read<AuthCubit>().signOut();
                        }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
