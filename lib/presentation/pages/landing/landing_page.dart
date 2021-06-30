import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/auth/auth_cubit.dart';
import '../../routes/router.gr.dart';

class LandingPage extends StatefulWidget {
  const LandingPage() : super();

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  void didChangeDependencies() {
    final bool isUserLoggedIn = context.read<AuthCubit>().state.isLoggedIn;
    final bool isUserCheckedFromAuthService =
        context.read<AuthCubit>().state.isUserCheckedFromAuthService;
    if (isUserLoggedIn) {
      AutoRouter.of(context).navigate(const HomeRoute());
    } else if (!isUserLoggedIn && isUserCheckedFromAuthService) {
      AutoRouter.of(context).navigate(const PhoneNumberSignInRoute());
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (p, c) =>
          p.isUserCheckedFromAuthService != c.isUserCheckedFromAuthService &&
          c.isUserCheckedFromAuthService,
      listener: (context, state) {
        final bool isUserLoggedIn = state.isLoggedIn;

        if (isUserLoggedIn) {
          AutoRouter.of(context).navigate(const HomeRoute());
        } else {
          AutoRouter.of(context).navigate(const PhoneNumberSignInRoute());
        }
      },
      child: const Scaffold(
        body: Center(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
