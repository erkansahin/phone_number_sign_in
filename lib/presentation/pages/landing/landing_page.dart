import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/auth/auth_cubit.dart';
import '../../routes/router.gr.dart';
import '../phone_number_sign_in/constants/constants.dart';
import '../phone_number_sign_in/widgets/gradient_container.dart';

class LandingPage extends StatefulWidget {
  const LandingPage() : super();

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      final bool isUserLoggedIn = context.read<AuthCubit>().state.isLoggedIn;
      final bool isUserCheckedFromAuthService =
          context.read<AuthCubit>().state.isUserCheckedFromAuthService;
      if (isUserLoggedIn) {
        AutoRouter.of(context).replace(const HomeRoute());
      } else if (!isUserLoggedIn && isUserCheckedFromAuthService) {
        AutoRouter.of(context).replace(const PhoneNumberSignInRoute());
      }
    });

    super.initState();
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
          AutoRouter.of(context).replace(const HomeRoute());
        } else {
          AutoRouter.of(context).replace(const PhoneNumberSignInRoute());
        }
      },
      child: const Scaffold(
        body: GradientContainer(
          gradientColors: [topGradientColor, bottomGradientColor],
          child: Center(
            child: CircularProgressIndicator(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
