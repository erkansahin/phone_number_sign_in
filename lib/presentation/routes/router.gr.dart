// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i1;
import 'package:flutter/material.dart' as _i2;

import '../pages/home/home_page.dart' as _i5;
import '../pages/landing/landing_page.dart' as _i3;
import '../pages/phone_number_sign_in/phone_number_sign_in_page.dart' as _i4;

class AppRouter extends _i1.RootStackRouter {
  AppRouter([_i2.GlobalKey<_i2.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i1.PageFactory> pagesMap = {
    LandingRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i3.LandingPage();
        }),
    PhoneNumberSignInRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return const _i4.PhoneNumberSignInPage();
        }),
    HomeRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return const _i5.HomePage();
        })
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig(LandingRoute.name, path: '/'),
        _i1.RouteConfig(PhoneNumberSignInRoute.name,
            path: '/phone-number-sign-in-page'),
        _i1.RouteConfig(HomeRoute.name, path: '/home-page')
      ];
}

class LandingRoute extends _i1.PageRouteInfo {
  const LandingRoute() : super(name, path: '/');

  static const String name = 'LandingRoute';
}

class PhoneNumberSignInRoute extends _i1.PageRouteInfo {
  const PhoneNumberSignInRoute()
      : super(name, path: '/phone-number-sign-in-page');

  static const String name = 'PhoneNumberSignInRoute';
}

class HomeRoute extends _i1.PageRouteInfo {
  const HomeRoute() : super(name, path: '/home-page');

  static const String name = 'HomeRoute';
}
