import 'dart:developer';
import 'package:clean_architecture_flutter/features/company/presentation/screens/dashboard.dart';
import 'package:clean_architecture_flutter/features/company/presentation/screens/saving_amount_screen.dart';
import 'package:clean_architecture_flutter/features/company/presentation/screens/withdraw_amount_screen.dart';
import 'package:clean_architecture_flutter/features/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouteName {
  static const String dashboard = 'dashboard';
  static const String saving = 'saving';
  static const String withdraw = 'withdraw';
  static const String history = 'history';
}

class AppRouter {
  AppRouter._();

  /// Key so we can navigate without context.
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  /*----------------------------------------*/

  static GoRouter? _baseRoutes;

  static GoRouter get baseRouters => _baseRoutes!;

  static List<GoRoute> get routes => _routes;

  static void init() {
    _baseRoutes = GoRouter(
      navigatorKey: navigatorKey,
      //observers: routeObservers,
      routes: <GoRoute>[...routes],
      redirect: (context, state) {
        log('url => ${state.uri.toString()}');
        return null;
      },
    );
  }

  static final _routes = <GoRoute>[
    GoRoute(
        name: '/',
        path: '/',
        builder: (context, state) {
          return SplashScreen();
        },
        routes: [
          GoRoute(
            name: AppRouteName.dashboard,
            path: AppRouteName.dashboard,
            builder: (context, state) => DashboardScreen(),
          ),
          GoRoute(
            name: AppRouteName.saving,
            path: AppRouteName.saving,
            builder: (context, state) => SavingAmountScreen(),
          ),
          GoRoute(
            name: AppRouteName.withdraw,
            path: AppRouteName.withdraw,
            builder: (context, state) => WithdrawAmountScreen(),
          ),
        ]),
  ];
}
