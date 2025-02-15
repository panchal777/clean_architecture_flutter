import 'package:clean_architecture_flutter/core/components/q_app_bar.dart';
import 'package:clean_architecture_flutter/features/company/presentation/widgets/dashboard_buttons.dart';
import 'package:clean_architecture_flutter/features/company/presentation/widgets/dashboard_cards.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: QAppBar(title: 'Dashboard', hideBackPressed: true),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Flexible(child: DashboardCards()),
              SizedBox(height: 10),
              DashboardButtons()
            ],
          ),
        ),
      ),
    );
  }
}
