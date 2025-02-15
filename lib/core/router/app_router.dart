import 'dart:developer';
import 'package:clean_architecture_flutter/features/company/presentation/screens/dashboard.dart';
import 'package:clean_architecture_flutter/features/company/presentation/screens/deposit_amount_screen.dart';
import 'package:clean_architecture_flutter/features/company/presentation/screens/statement_screen.dart';
import 'package:clean_architecture_flutter/features/company/presentation/screens/withdraw_amount_screen.dart';
import 'package:clean_architecture_flutter/features/splash/splash_screen.dart';
import 'package:clean_architecture_flutter/injectors/main_injector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../features/company/presentation/bloc/company_bloc.dart';

class AppRouteName {
  static const String dashboard = '/dashboard';
  static const String saving = '/saving';
  static const String withdraw = '/withdraw';
  static const String history = '/history';
  static const String statement = '/statement';
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
    ),
    //initialising local bloc
    GoRoute(
      name: AppRouteName.dashboard,
      path: AppRouteName.dashboard,
      builder: (context, state) => MultiBlocProvider(providers: [
        BlocProvider<CompanyBloc>(
            create: (context) => MainInjector.instance<CompanyBloc>()
              ..add(CompanyEvent.getDashboardData()))
      ], child: DashboardScreen()),
    ),
    GoRoute(
      name: AppRouteName.saving,
      path: AppRouteName.saving,
      builder: (context, state) => MultiBlocProvider(providers: [
        BlocProvider<CompanyBloc>(
            create: (context) => MainInjector.instance<CompanyBloc>())
      ], child: DepositAmountScreen()),
    ),
    GoRoute(
      name: AppRouteName.withdraw,
      path: AppRouteName.withdraw,
      builder: (context, state) => MultiBlocProvider(providers: [
        BlocProvider<CompanyBloc>(
            create: (context) => MainInjector.instance<CompanyBloc>())
      ], child: WithdrawAmountScreen()),
    ),
    GoRoute(
      name: AppRouteName.statement,
      path: AppRouteName.statement,
      builder: (context, state) => MultiBlocProvider(providers: [
        BlocProvider<CompanyBloc>(
            create: (context) => MainInjector.instance<CompanyBloc>()
              ..add(CompanyEvent.getTransactionHistory()))
      ], child: StatementScreen()),
    ),
  ];
}
