import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/auth/auth_cubit.dart';
import '../../injection.dart';
import '../routes/router.gr.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final BotToastNavigatorObserver botToastNavigatorObserver =
      BotToastNavigatorObserver();
  final botToastBuilder = BotToastInit();
  final AppRouter _appRouter = AppRouter();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (context) => getIt<AuthCubit>(),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerDelegate: _appRouter.delegate(
            navigatorObservers: () => [
                  botToastNavigatorObserver,
                ]),
        routeInformationParser: _appRouter.defaultRouteParser(),
        builder: (context, child) {
          return botToastBuilder(context, child);
        },
        title: 'Sponty',
      ),
    );
  }
}
