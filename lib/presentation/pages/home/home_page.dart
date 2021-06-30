import 'package:auto_route/auto_route.dart';
import 'package:bare_bones/presentation/pages/phone_number_sign_in/widgets/auth_text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/auth/auth_cubit.dart';
import '../../routes/router.gr.dart';

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
        child: Scaffold(
          body: Center(
            child: AuthTextButton(
                text: "Logout",
                onPressed: () {
                  context.read<AuthCubit>().signOut();
                }),
          ),
        ),
      ),
    );
  }
}
