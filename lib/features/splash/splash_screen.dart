import 'dart:async';
import 'package:clean_architecture_flutter/core/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreen createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3),
      () => context.go(AppRouteName.dashboard),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: FlutterLogo(size: MediaQuery.of(context).size.height));
  }
}
