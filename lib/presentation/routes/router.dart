import 'package:auto_route/auto_route.dart';

import '../pages/landing/landing_page.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: LandingPage, initial: true),
  ],
)
class $AppRouter {}
