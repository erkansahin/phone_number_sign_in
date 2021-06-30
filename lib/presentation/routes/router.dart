import 'package:auto_route/auto_route.dart';

import '../pages/home/home_page.dart';
import '../pages/landing/landing_page.dart';
import '../pages/phone_number_sign_in/phone_number_sign_in_page.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: LandingPage, initial: true),
    AutoRoute(
      page: PhoneNumberSignInPage,
    ),
    AutoRoute(
      page: HomePage,
    ),
  ],
)
class $AppRouter {}
